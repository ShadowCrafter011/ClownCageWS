import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import $ from "jquery"

// Connects to data-controller="action-status"
export default class extends Controller {
  connect() {
    var self = this
    var btn = $(this.element)

    this.error_timeout = setTimeout(function() {
      btn.text("Error!")
      btn.addClass("btn-danger")
      btn.removeClass("btn-success")

      clearInterval(self.check_interval)
    }, 3000)
    this.reset_timeout = setTimeout(function() {
      btn.text("Dispatch")
      btn.addClass("btn-success")
      btn.removeClass("btn-danger");
    }, 6000)

    this.check_interval = setInterval(function() {
      Rails.ajax({
        url: `/admin/action_status/${btn.data("callback-uuid")}`,
        type: "get",
        success: function(data) {
          console.log(data)
          if (data.executed) {
            clearTimeout(self.error_timeout)
            clearTimeout(self.reset_timeout)
            
            setTimeout(function() {
              clearTimeout(self.check_interval)
            }, 10_000)

            setTimeout(function() {
              btn.text("Dispatch")
            }, 3000)

            btn.text("Success!")
          }
          if (data.error) {
            $("#error-toast-header").text(`Error on ${data.name}`)
            $("#error-toast-body").text(`An error happened whilst executing action ${data.name}`)

            bootstrap.Toast.getOrCreateInstance($("#error-toast")).show()
            clearInterval(self.check_interval)
          }
        }
      })
    }, 500)
  }
}
