// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import { autocompleteSearch } from "./components/autocomplete"
import "bootstrap"

document.addEventListener('turbo:load', function () {
  autocompleteSearch();
})
