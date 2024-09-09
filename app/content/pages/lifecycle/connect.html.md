---
layout: article
title: Don't Overuse `connect`
category: lifecycle
preview_text: Use Stimulus values as the single source of truth for your controller state.
author: julianrubisch
cache: true
new: true
---

The `connect` lifecycle callback is the most used hook to set up a controller when it is (in some circumstances repeatedly) connected to the DOM.

It is the correct place to instantiate any 3rd party plugins, such as Swiper, Dropzone, Chartjs, Threejs etc. It is also the best place to put any preconditions or cleanup of the DOM, for example based on browser capabilities.

It might _not_ be the best place to

- set up controller state (use [values](/architecture/state-management) instead)
- hook up additional event listeners (just use the regular Stimulus DOM notation instead, as they will automatically clean up after themselves)

Bad
{: .label .label-red }

```html
<div data-controller="toggle">
  <button data-toggle-target="button">Click to open</button> 
  <div data-toggle-target="panel" class="hidden">
    <!-- ... -->
  </div>
</div>
{: .border .border-red }
```

```js
// toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "panel"];
  
  connect() {
    this.open = false;
    this.buttonTarget.addEventListener("click", this.toggle.bind(this));
  }
  
  toggle() {
    this.open = !this.open;
    this.panelTarget.classList.toggle("hidden");
  }
}
{: .border .border-red }
```

Good
{: .label .label-green }

```html
<div data-controller="toggle" 
  data-toggle-open-value="false"
  data-toggle-hidden-class="hidden">
  <button data-action="toggle#toggle">Click to open</button> 
  <div data-toggle-target="panel" class="hidden">
    <!-- ... -->
  </div>
</div>
{: .border .border-green }
```

```js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { open: Boolean };
  static targets = ["panel"];
  static classes = ["hidden"];
  
  toggle() {
    this.openValue = !this.openValue;
  }
  
  openValueChanged() {
    if(this.openValue) {
      this.panelTarget.classList.add(this.hiddenClass);
    } else {
      this.panelTarget.classList.remove(this.hiddenClass);
    }
  }
}
{: .border .border-green }
```

### Rationale
One of the reasons for the rules above is that putting every type of setup there will bloat it and make it confusing to read. It will potentially also lead to violations of the [Single Responsibility Principle](/solid/single-responsibility) because it's easy to add more generic code that will eventually blur boundaries. The [Open Close Principle](/solid/open-closed) has a good example.


### Contraindications
These are mere guidelines, of course. Sometimes you cannot use values to hold state, because it might not be serializable (such as with whole instances of Swiper, etc.). Sometimes you have to listen for events but not trigger a Stimulus _action_, but call a private method. The lines are blurry of course, but when in doubt, I'd advocate to try and follow these rules of thumb.
