# config/importmap.rb

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# CORRECTED: Add this specific pin for chartkick/chart.js
pin "chartkick", to: "chartkick.js" # Ensure this points to the main chartkick.js if separate
pin "Chart.bundle", to: "Chart.bundle.js" # This is likely needed if you use Chart.bundle directly
pin "chartkick/chart.js", to: "chartkick/chart.js" # THIS IS THE MISSING PIN

pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"