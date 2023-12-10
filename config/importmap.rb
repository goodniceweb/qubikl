# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "leaflet", to: "https://unpkg.com/leaflet/dist/leaflet-src.esm.js"
pin "tinycolor", to: "https://esm.sh/tinycolor2"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
