import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"
import $ from "jquery"

// Connects to data-controller="clown"
export default class extends Controller {
  static targets = [ "title", "urlContainer", "url" ]

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
            $(stimulus.urlContainerTarget).remove();
            break;

          case "location":
            if ($("#current-url").length == 0) {
              $(stimulus.element).append("<h3 id=\"current-url\" data-clown-target=\"urlContainer\">Momentane URL: <span data-clown-target=\"url\"></span></h3>");
            }

            $(stimulus.urlTarget).text(data.href);
            break;

          default:
            break;
        }

      }
    });
  }
}
