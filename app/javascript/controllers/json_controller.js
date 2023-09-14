import { Controller } from "@hotwired/stimulus"
import $ from "jquery"

// Connects to data-controller="json"
export default class extends Controller {
  static targets = ["input", "highlight", "scroll"]

  connect() {
    let highlight = $(this.highlightTarget)
    let input = $(this.inputTarget)
    input.val(highlight.text())

    let height = input.prop("scrollHeight")
    input.css("height", `${height}px`)
    $(this.scrollTarget).css("height", `${height}px`)

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

    let height = input.prop("scrollHeight")
    input.css("height", `${height}px`)
    $(this.scrollTarget).css("height", `${height}px`)

    this.sync_scroll()

    Prism.highlightElement(highlight.get(0))
  }

  sync_scroll() {
    let scroll = $(this.scrollTarget)
    let input = $(this.inputTarget)
    scroll.scrollTop(input.scrollTop())
    scroll.scrollLeft(input.scrollLeft())
  }

  new_line() {
  }
}
