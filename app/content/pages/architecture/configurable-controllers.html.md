---
layout: article
title: Configurable Controllers
category: architecture
preview_text: Late binding of dependencies (in the simplest case above, the value of a CSS class. Other examples may include the ID of a DOM element or a CSS selector) ensures that your controller is re-usable across multiple use cases.
author: julianrubisch
---

Bad
{: .label .label-red}

```html
<!-- index.html -->
<a href="#" data-controller="toggle" data-action="click->toggle#toggle">
  Toggle
</a>
{: .border .border-red}
```

```js
// toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(e) {
    e.preventDefault();
    this.element.classList.toggle("active");
  }
}
{: .border .border-red}
```

Good
{: .label .label-green}

```html
<!-- index.html -->
<a href="#" data-controller="toggle" data-action="click->toggle#toggle" data-toggle-active-class="active">
  Toggle
</a>
{: .border .border-green}
```

```js
// toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["active"];

  toggle(e) {
    e.preventDefault();
    this.element.classList.toggle(this.activeClass);
  }
}
{: .border .border-green}
```

### Rationale
Late binding of dependencies (in the simplest case above, the value of a [CSS class](https://stimulus.hotwired.dev/reference/css-classes). Other examples may include the ID of a DOM element or a CSS selector) ensures that your controller is re-usable across multiple use cases.

Simply moving that value out of the controller into a dataset property will make your controllers more flexible, and you'll have to write less specialized JavaScript in favor of more adaptable controllers that allow dependencies to be injected and thus obey the [Single Reponsibility Principle](../solid/single-responsibility).

<!-- ### Codesandbox Example -->

<!-- <iframe -->
<!--      src="https://codesandbox.io/embed/vigilant-cherry-jrjng?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Ftoggle_controller.js&theme=dark" -->
<!--      style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" -->
<!--      title="vigilant-cherry-jrjng" -->
<!--      allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking" -->
<!--      sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts" -->
<!--    ></iframe> -->
