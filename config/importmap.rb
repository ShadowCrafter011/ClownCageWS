# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "tippy", to: "https://unpkg.com/tippy.js@6"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "jquery", to: "jquery.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.7-2/lib/assets/compiled/rails-ujs.js"
pin "prism-core", to: "https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-core.min.js"
pin "prism-json", to: "https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-json.min.js"
pin "prism-markup", to: "https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-markup.min.js"
pin "jquery.dirtyforms", to: "jquery.dirtyforms.js"
