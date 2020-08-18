---
title: Use Lifecycle Events for Setup and Teardown
nav_order: 1
parent: Integrating Libraries
---

# Use Lifecycle Events for Setup and Teardown

#### by @excid3 {% avatar excid3 size=24 %}
{: .fs-3 }

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

Suppose you are fetching some HTML from a server and rendering it to your page asynchronously. If the HTML you are obtaining requires the initialization of javascript, then you will have to reinitialize that javascript yourself somehow - you will have to rerun the code in the "bad" example given above. This can be cumbersome to trigger. But if the initialization is done in the "good" manner above, then you can automatically reinitialize that javascript **for free** with stimulus without any additional code. Of course course, the html you are returning must be sprinkled with the relevant and correct stimulus js attributes.

### Contraindications
Not all Javascript libraries have good teardown methods to remove their functionality from the page.

### Codesandbox Example
<iframe
     src="https://codesandbox.io/embed/adoring-galois-u3xtu?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Feasymde_controller.js&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="adoring-galois-u3xtu"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
