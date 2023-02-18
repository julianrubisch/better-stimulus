---
title: Use &lt;template&gt; to Restore DOM State
nav_order: 1
parent: DOM Manipulation
---

# Use `<template>` to Restore DOM State

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }

## Pain Point
- You're dealing with an external library that yanks HTML off your page and you need to restore it.
- You want to restore the page to a known state before leaving, e.g. to prepare for Turbolinks caching.

Good
{: .label .label-green }

```html
<!-- index.html -->
<div data-controller="modal">
  <template data-target="modal.template">
    <div>
      <a href="#" data-action="modal#show">Click Me</a>
      <div class="modal invisible" data-target="modal.modal">
        <h1>A Modal</h1>
        <a href="#" data-action="modal#hide">Hide Me</a>
      </div>
    </div>
  </template>
</div>
```

```js
// modal_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["template", "modal"];

  connect() {
    this.element.insertAdjacentHTML("beforeend", this.templateTarget.innerHTML);
  }

  show(e) {
    e.preventDefault();

    // this is a stand-in for an external show method, e.g. in Bootstrap or SemanticUI
    this.modalTarget.classList.remove("invisible");
    this.modalTarget.classList.add("visible");
  }

  hide(e) {
    e.preventDefault();

    // this is a stand-in for an external hide method that will
    // yank the modal HTML off your page
    this.element.removeChild(this.element.lastElementChild);

    this.element.insertAdjacentHTML("beforeend", this.templateTarget.innerHTML);
  }
}
```

### Rationale
In some cases, it can be necessary to reset your DOM to a known state before leaving the page, or after triggering some action. One use case might be when dealing with external UI libraries like SemanticUI or Bootstrap that will yank away some HTML after, for example, closing a modal.

Furthermore this can be useful when using Turbolinks, because it will cache the current state before navigating away and show it as a preview when doing a restoration visit.

### Counterindications
Certainly there are easier ways to restore markup when manipulating the DOM, especially when you're dealing only with single elements on which you toggle CSS classes. Whenever you need to replace larger portions of HTML, this can be a viable option, though.

### References
- [https://dev.to/adrienpoly/animations-with-turbolinks-and-stimulus-4862](https://dev.to/adrienpoly/animations-with-turbolinks-and-stimulus-4862)

### Codesandbox Example
<iframe src="https://codesandbox.io/embed/dazzling-meadow-h8dru?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Fmodal_controller.js&theme=dark&view=preview"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="dazzling-meadow-h8dru"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
