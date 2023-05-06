import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"
import $ from "jquery"

// Connects to data-controller="app"
export default class extends Controller {
  connect() {
    $(document).on("keypress", e => {
      if (e.originalEvent.code == "KeyQ" && e.originalEvent.ctrlKey) {
        Turbo.visit("/urls")
      }
    });
  }
}
