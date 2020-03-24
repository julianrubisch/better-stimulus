import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element
      .querySelectorAll("a.btn.btn-outline")
      .forEach(element => element.remove());

    this.element.querySelectorAll("div.highlighter-rouge").forEach(element => {
      const wrapper = document.createElement("div");
      wrapper.dataset.controller = "copy";
      wrapper.dataset["copyContent"] = "Copied";
      element.parentNode.insertBefore(wrapper, element);
      wrapper.appendChild(element);
      wrapper.firstChild.insertAdjacentHTML(
        "beforeBegin",
        '<div class="d-flex mb-3" style="justify-content: space-between; flex-direction: row-reverse;"><a class="btn btn-outline" data-action="click->copy#copy" data-target="copy.trigger">Copy</a></div>'
      );
      element.querySelector("code").dataset.target = "copy.source";
    });

    this.element.querySelectorAll("p.label").forEach(label => {
      const wrapper = label.nextElementSibling;
      wrapper.firstChild.appendChild(label);
    });
  }
}
