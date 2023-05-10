import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"
import $ from "jquery"

// Connects to data-controller="clown"
export default class extends Controller {
  static targets = [ "title" ]

  connect() {
    const stimulus = this;

    consumer.subscriptions.create("WebChannel", {
      received(data) {
        
        switch (data.type) {
          case "connect":
            $(stimulus.titleTarget).text("Der Clown ist online!");
            break;
          
          case "disconnect":
            if (data.num_conns > 0) return;

            $(stimulus.titleTarget).text("Der Clown ist nicht online");
            break;

          default:
            break;
        }

      }
    });
  }
}
