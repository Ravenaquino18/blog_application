// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"

// Add a Turbo listener to ensure charts are always redrawn on navigation.
document.addEventListener("turbo:load", function() {
  if (typeof Chartkick !== 'undefined' && Chartkick.charts) {
    for (const id in Chartkick.charts) {
      if (Chartkick.charts[id].redraw) {
        Chartkick.charts[id].redraw();
      }
    }
  }
}); 