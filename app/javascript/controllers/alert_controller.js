import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("fade-out")
    }, 3000);
    setTimeout(() => {
      this.element.remove()
    }, 4000)
  }
}
