import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link"
export default class extends Controller {
  click(event) {
    event.preventDefault();
    Turbo.visit($(this.element).attr("href"))
  }
}
