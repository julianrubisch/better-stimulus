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
// initialization code
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

### Fetching HTML over the wire

Let's consider a situation where you are fetching some HTML asynchronously and are adding it to the DOM. Below is an example of the HTML that you could be fetching:

Bad
{: .label .label-red }

```html
<-- we're fetching this via ajax and rendering it in the DOM -->
       
<div class="easymde">...</div>
```
Because you are fetching this asynchronously without stimulus, the EasyMDE javascript code will not work and initialize - this will only happen after turbolinks loads - and that won't happen again when you fetch the HTML! You will have to re-run the initialisation code:

```js
// initialization code - you'll have to manually trigger and rerun the below code:
import EasyMDE from "easymde"
// etc ....
```

But, if you wrap the returned HTML using stimulus attributes (see below) then you will not have to re-run the initialization code. You will get that for free!

Good
{: .label .label-green }

```html
<div data-controller="easymde" data-target="easymde.field">...</div>
```

**Summary:** The benefit of using stimulus when sending HTML over the wire (i.e. fetching HTML via AJAX and rendering it on your page) is that you will not need to trigger and re-run any initialization code. You will get that for free, leading to huge improvements in the readability and maintainability of your code.

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
