import { Controller } from "@hotwired/stimulus"
import $ from "jquery"

// Connects to data-controller="json"
export default class extends Controller {
  static targets = ["input", "highlight", "scroll"]

  connect() {
    let highlight = $(this.highlightTarget)
    let input = $(this.inputTarget)
    input.val(highlight.text())

    let height = $(this.scrollTarget).prop("scrollHeight")
    input.css("height", `${height}px`)
    $("#json-editor").css("height", `${height}px`)

    Prism.highlightElement(highlight.get(0))
  }

  update() {
    let highlight = $(this.highlightTarget)
    let input = $(this.inputTarget)

    let text = input.val()

    if (text[text.length - 1] == "\n") {
      text += " "
    }

    highlight.text(text)

    let height = $(this.scrollTarget).prop("scrollHeight")
    input.css("height", `${height}px`)
    $("#json-editor").css("height", `${height}px`)

    this.sync_scroll()

    Prism.highlightElement(highlight.get(0))
  }

  sync_scroll() {
    let scroll = $(this.scrollTarget)
    let input = $(this.inputTarget)
    scroll.scrollLeft(input.scrollLeft())
  }

  new_line(event) {
    event.preventDefault()

    let input = $(this.inputTarget)

    let value = input.val()
    let rows = value.substr(0, input.get(0).selectionStart).split("\n")
    let current_row = rows[rows.length - 1]
    let current_row_char_array = current_row.split("")
    
    let indentation = 0
    for (let char of current_row_char_array) {
      if (char == " ") {
        indentation++
      } else {
        break
      }
    }

    if (current_row_char_array[current_row_char_array.length - 1] == "{") {
      indentation += 4
    }

    this.insert_into_value(input, "\n" + " ".repeat(indentation))

    this.update()
  }

  tab(event) {
    event.preventDefault()
    this.insert_into_value($(this.inputTarget), "    ")
  }

  insert_into_value(element, text) {
    let value_array = element.val().split("");

    let new_start = element.get(0).selectionStart + text.length;
    
    element.val([
        ...value_array.slice(0, element.get(0).selectionStart),
        text,
        ...value_array.slice(element.get(0).selectionEnd)
    ].join(""))

    element.get(0).selectionStart = new_start
    element.get(0).selectionEnd = new_start
  }
}
