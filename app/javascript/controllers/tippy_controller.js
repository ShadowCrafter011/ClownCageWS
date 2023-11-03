import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tippy"
export default class extends Controller {
  connect() {
    tippy(this.element, { theme: "material" });
  }
}
