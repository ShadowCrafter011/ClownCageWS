import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="json"
export default class extends Controller {
  static targets = ["input", "highlight", "scroll", "form"]

  connect() {
    $(this.formTarget).dirtyForms()

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
    let current_row = this.get_row(value, input.get(0).selectionStart)
    let current_row_char_array = current_row.split("")
    
    let indentation = 0
    for (let char of current_row_char_array) {
      if (char == " ") {
        indentation++
      } else {
        break
      }
    }

    let last_char = current_row_char_array[current_row_char_array.length - 1]
    if (last_char == "{" || last_char == "[") {
      indentation += 4
    }

    this.insert_into_value(input, "\n" + " ".repeat(indentation))

    this.update()
  }

  tab(event) {
    event.preventDefault()
    this.insert_into_value($(this.inputTarget), "    ")
  }

  key(event) {
    if (!(event.key == "}" || event.key == "]")) return;
    let input = $(this.inputTarget)
    let current_row = this.get_row(input.val(), this.inputTarget.selectionStart)
    let cached_selection_start = this.inputTarget.selectionStart
    if (current_row.trim() == "") {
      event.preventDefault()
      let char_array = input.val().split("")
      input.val([
        ...char_array.slice(0, this.inputTarget.selectionStart - 4),
        event.key,
        ...char_array.slice(this.inputTarget.selectionStart)
      ].join(""))
    }
    this.inputTarget.selectionStart = cached_selection_start - 3
    this.inputTarget.selectionEnd = this.inputTarget.selectionStart
    this.update()
  }

  get_row(text, at) {
    let rows = text.substr(0, at).split("\n")
    return rows[rows.length - 1]
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
