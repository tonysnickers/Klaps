import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lottie"
export default class extends Controller {
  static values = { dashboardUrl: String }
  connect() {
    setTimeout(() => {
      this.element.remove()
      window.location = this.dashboardUrlValue
    }, 6000);
  }
}
