// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"
import "chartkick/chart.js" 
// Add a Turbo listener to ensure charts are always redrawn on navigation.
document.addEventListener("turbo:load", function() {
  // We check if Chartkick is defined to avoid errors on pages without charts.
  if (typeof Chartkick !== 'undefined') {
    Chartkick.init();
  }
});import "channels"
