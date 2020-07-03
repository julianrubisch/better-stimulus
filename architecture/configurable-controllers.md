---
title: Configurable Controllers
nav_order: 2
parent: Architecture
---

# Write Configurable Controllers

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }

Bad
{: .label .label-red}

```html
<!-- index.html -->
<a href="#" data-controller="toggle" data-action="click->toggle#toggle">
  Toggle
</a>
```
{: .border-red}

```js
// toggle_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  toggle(e) {
    e.preventDefault();
    this.element.classList.toggle("active");
  }
}
```
{: .border-red}

Good
{: .label .label-green}

```html
<!-- index.html -->
<a href="#" data-controller="toggle" data-action="click->toggle#toggle" data-toggle-css-class="active">
  Toggle
</a>
```
{: .border-green}

```js
// toggle_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  toggle(e) {
    e.preventDefault();
    this.element.classList.toggle(this.cssClass);
  }

  get cssClass() {
    return this.data.get("cssClass");
  }
}
```
{: .border-green}

### Rationale
Late binding of dependencies (in the simplest case above, the value of a CSS class. Other examples may include the ID of a DOM element or a CSS selector) ensures that your controller is re-usable across multiple use cases.

Simply moving that value out of the controller into a dataset property will make your controllers more flexible, and you'll have to write less specialized JavaScript in favor of more adaptable controllers that allow dependencies to be injected and thus obey the [Single Reponsibility Principle](../solid/single-responsibility.md).

### Codesandbox Example

<iframe
     src="https://codesandbox.io/embed/vigilant-cherry-jrjng?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Ftoggle_controller.js&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="vigilant-cherry-jrjng"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
