import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"
import $ from "jquery"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    let subscribe_request = { channel: "WebChannel", room: "navbar" }
    this.subscription = consumer.subscriptions.create(subscribe_request, {
      received: this.reload,
      stimulus: this
    })
  }

  reload(data) {
    if (data.action != "reload_navbar") return
    this.stimulus.element.reload()
    bootstrap.Toast.getOrCreateInstance($("#new-consumer-toast")).show()
  }

  disconnect() {
    this.subscription.unsubscribe()
  }
}
