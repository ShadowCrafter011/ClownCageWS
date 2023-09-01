import { Controller } from "@hotwired/stimulus";
import $ from "jquery";

// Connects to data-controller="json"
export default class extends Controller {
  connect() {
    var self = this;
    $(this.element).on("keydown", function(event) {
      $(self.element).removeClass("prettyprinted");
      PR.prettyPrint();

      if (event.keyCode != 13) return;
    });
  }
}
