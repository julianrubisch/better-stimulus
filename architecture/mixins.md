---
title: Mixins
nav_order: 2
parent: Architecture
---

# Mixins

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }

Bad
{: .label .label-red}

```js
// overlay_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  showOverlay(e) {
    // ...
  }
  
  hideOverlay(e) {
    // ...
  }
}
```
{: .border-red}

```js
// dropdown_controller.js
import OverlayController from "./overlay_controller";

export default class extends OverlayController {
  //...
}

// flyout_controller.js
import OverlayController from "./overlay_controller";

export default class extends OverlayController {
  //...
}
```
{: .border-red}

Good
{: .label .label-green}

```js
// mixins/useOverlay.js
export const useOverlay = controller => {
  Object.assign(controller, {
    showOverlay(e) {
      // ...
    },
    hideOverlay(e) {
      // ...
    }
  });
};
```
{: .border-green}

```js
// dropdown_controller.js
import { useOverlay } from "./mixins/useOverlay";

export default class extends Controller {
  connect() {
    useOverlay(this);
  }

  //...
}

// flyout_controller.js
import { useOverlay } from "./mixins/useOverlay";

export default class extends Controller {
  connect() {
    useOverlay(this);
  }

  //...
}
```
{: .border-green}

### Rationale
Stimulus controllers are meant to be used as mixins themselves (i.e. applying multiple controllers to one DOM element, thus mixing in behavior). Sometimes though, it might even be advisable to share behavior on the controller level. [Inheritance](./inheritance.md) isn't always the answer to this - more often than not, it leads to architectural issues down the road, e.g. when you discover that you need to inherit behavior from two different parents - which is impossible in JavaScript. Often, it's preferable to mix in behavior that can be used across controllers with a simple trick.

If you're unsure about whether inheritance or mixin is the correct pattern, ask yourself:

- does my controller have a _is a_ relation to the target => **use inheritance**
- does my controller have a _acts as a_ relation to the target => **use mixins**

### Counterindications
Mixins might still not be the right choice, *composition* might suit your needs even better. Is what you're modelling a trait (_acts as a_), or a collaborator (_has a_)? Use composition, i.e. model your collaborator as a separate JS module or class and instantiate it in the `connect` method!

### References
- Adrien Poly's [Stimulus Use](https://github.com/stimulus-use/stimulus-use)

### Codesandbox Example

<iframe
     src="https://codesandbox.io/embed/recursing-almeida-2kutm?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fmixins%2FuseOverlay.js&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="recursing-almeida-2kutm"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
