import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="close"
export default class extends Controller {
  static targets = ["alerts", "notice"];
  static values = { timeout: Number };

  connect() {
    setTimeout(() => this.dismiss(), this.timeoutValue);
  }

  dismiss() {
    this.element.remove();
  }
}
