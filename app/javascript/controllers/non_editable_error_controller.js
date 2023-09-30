import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="non-editable-error"
export default class extends Controller {
  static targets = ["name"];

  show(event) {
    event.preventDefault();
    var name = $(this.nameTarget);
    let initial = name.text();
    name.addClass("error");
    name.text("Action is not editable");
    setTimeout(function() {
      name.removeClass("error");
      name.text(initial);
    }, 2000);
  }
}
