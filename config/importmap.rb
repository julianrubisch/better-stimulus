# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/clipboard", to: "@stimulus-components--clipboard.js" # @5.0.0
pin "@domchristie/turn", to: "@domchristie--turn.js" # @3.1.1
pin "@pagefind/default-ui", to: "@pagefind--default-ui.js" # @1.1.0
pin "@stimulus-components/dialog", to: "@stimulus-components--dialog.js" # @1.0.1
