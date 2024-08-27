import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input"];
  connect() {}

  disconnect() {
    this.inputTarget.value = ""
  }

  debounce() {
    clearTimeout(this.timeoutId);
    this.timeoutId = setTimeout(() => {
      this.element.requestSubmit();
    }, 3000);
  }
}
