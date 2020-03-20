import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element
      .querySelectorAll("a.btn.btn-outline")
      .forEach(element => element.remove());
    this.element.querySelectorAll("div.highlighter-rouge").forEach(element => {
      element.insertAdjacentHTML(
        "beforeBegin",
        '<div class="d-flex mb-3" style="justify-content: flex-end"><a class="btn btn-outline" data-action="copy#copy">Copy</a></div>'
      );
    });
  }
}
