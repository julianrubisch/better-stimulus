---
title: Use Lifecycle Events for Setup and Teardown
nav_order: 1
parent: Integrating Libraries
---

# Use Lifecycle Events for Setup and Teardown

## Lifecycle events provide the perfect mechanism to make third-party Javascript libraries compatible with Turbolinks

Bad
{: .label .label-red }

```js
import EasyMDE from "easymde"

let editors = [];

document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll(".easymde").forEach(function(element) {
    let editor = new EasyMDE({ element })
    editors.push(editor)
  })
});

document.addEventListener("turbolinks:before-cache", function() {
  editors.forEach(function(editor) {
    editor.toTextArea()
  }
});
```
{: .border-red }

Good
{: .label .label-green }

```html
<div data-controller="easymde" data-target="easymde.field">...</div>
```
{: .border-green }

```js
import EasyMDE from "easymde"

export default class extends Controller {
  static targets = [ "field" ]

  connect() {
    this.editor = new EasyMDE({
      element: this.fieldTarget,
    })
  }

  disconnect() {
    this.editor.toTextArea()
  }
}
```
{: .border-green }

### Rationale
Using Stimulus lifecycle events allows you to make most Javascript libraries compatible with Turbolinks without additional effort. You can use the `connect` lifecycle event to setup the instance and the `disconnect` event to teardown.

Stimulus creates separate instances automatically which also saves you from maintaining an array of active instances that need to be torn down later.

Each instance can pull its own unique configuration from data attributes from the Stimulus controller to make each instance separately configurable.

### Contraindications
Not all Javascript libraries have good teardown methods to remove their functionality from the page.
