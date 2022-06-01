import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date"
export default class extends Controller {
  connect() {
    mobiscroll.datepicker('#date-picker', {
      controls: ['date'],
      display: 'anchored',
      touchUi: true
    });
    document.getElementById('show-picker').addEventListener('click', function () {
      instance.open();
      return false;
    });
  };
}
