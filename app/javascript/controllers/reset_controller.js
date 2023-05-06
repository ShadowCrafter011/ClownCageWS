import { Controller } from "@hotwired/stimulus"
import $ from "jquery"

// Connects to data-controller="reset"
export default class extends Controller {
  static targets = [ "text" ]

  connect() {
    $(this.element).trigger("reset");
    setTimeout(() => {
      let text = $(this.textTarget);
      text.attr("value", text.data("origin"));
    }, 2500);
  }
}
