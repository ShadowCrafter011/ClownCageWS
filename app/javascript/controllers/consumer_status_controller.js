import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer";
import $ from "jquery";

// Connects to data-controller="consumer-status"
export default class extends Controller {
  connect() {
    let subscribe_request = { channel: "WebChannel", room: this.element.id }
    this.subscription = consumer.subscriptions.create(subscribe_request, {
      received: this.reload_turbo_frame,
      stimulus: this
    });

    // Always reload frames every 10 seconds
    var self = this;
    this.reload_interval = setInterval(function() {
      // TODO: Uncomment this, removed to unclog rails logs
      // self.element.reload();
    }, 10000);
  }

  disconnect() {
    this.subscription.unsubscribe();
    clearTimeout(this.reload_interval);
  }

  reload_turbo_frame(data) {
    if (data.action != "reload_consumer_frame") return;

    if (this.stimulus.next_reload) {
      clearTimeout(this.stimulus.next_reload);
    }

    this.stimulus.element.reload();

    var self = this;
    this.stimulus.next_reload = setTimeout(function() {
      self.stimulus.element.reload();
    }, 5000);
  }
}
