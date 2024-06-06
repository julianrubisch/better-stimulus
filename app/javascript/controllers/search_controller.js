import { Controller } from "@hotwired/stimulus";
import { PagefindUI } from "@pagefind/default-ui";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["button", "dialog", "search"];

  connect() {
    this.search = new PagefindUI({
      element: this.searchTarget,
      highlightParam: "highlight",
      autofocus: true,
      showImages: false,
    });
  }

  disconnect() {
    this.search.destroy();
  }

  open() {
    this.dialogTarget.showModal();
  }

  close() {
    this.dialogTarget.close();
  }
}
