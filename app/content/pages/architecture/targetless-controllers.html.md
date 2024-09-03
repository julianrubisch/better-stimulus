---
layout: article
title: Targetless Controllers
category: Avoid mixing targetless controllers with those attached to a target.
preview_text: Foo
author: julianrubisch
cache: true
new: true
---

In general, there are two types of controllers:

- those that act on the element the controller is attached on itself,
- those that act on one or several `target`s.

You should avoid mixing the two.

```html
<form data-controller="form">
  <span data-form-target="indicator"></span>
  
  <input type="number" data-action="change->form#submit" />
</form>
```
Bad
{: .label .label-red}

```js
// form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["indicator"];
  
  submit() {
    this.indicatorTarget.textContent = "Saving...";
    this.element.requestSubmit();
  }
}
{: .border .border-red}
```

Good
{: .label .label-green}

```html
<form data-controller="form form-indicator" data-action="submit->form-indicator#display">
  <span data-form-indicator-target="indicator"></span>
  
  <input type="number" data-action="change->form#submit" />
</form>
```

```js
// form_indicator_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["indicator"];

  display() {
    this.indicatorTarget = "Saving...";
  }
}

// form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit() {
    this.element.requestSubmit();
  }
}
{: .border .border-green}
```

### Rationale

As already hinted above, mixing targetless controllers with "targetful" controllers is a smell that points at a possible [Single Responsibility](../solid/single-responsibility) violation.

If you're unsure, ask "What would be reasons for this controller to change"? If you come up with one for the `target`s and one for `this.element`, that's an instance of [divergent change](https://refactoring.guru/smells/divergent-change), and you should decouple it into two or more controllers, and use outlets or events to communicate between them.

In the improved example above, this is done by splitting the controller responsible for the indicator from the form controller. A form element emits `submit` whenever `requestSubmit` is called, so we can utilize this for triggering the display of the "Saving" indicator.
