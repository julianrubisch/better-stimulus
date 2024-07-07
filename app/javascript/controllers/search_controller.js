import { Controller } from "@hotwired/stimulus";
import Dialog from "@stimulus-components/dialog";
import { PagefindUI } from "@pagefind/default-ui";

// Connects to data-controller="search"
export default class extends Dialog {
  static targets = ["button", "dialog", "search"];

  connect() {
    super.connect();

    this.search = new PagefindUI({
      element: this.searchTarget,
      highlightParam: "highlight",
      autofocus: true,
      showImages: false,
    });
  }

  disconnect() {
    super.disconnect();

    this.search.destroy();
  }
}
