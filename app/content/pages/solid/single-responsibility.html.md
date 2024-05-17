---
title: Single Responsibility Principle
category: solid
---

# Single Responsibility Principle

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }


Especially when applying Stimulus to your application for the first time, it is tempting to write your controllers in a _page controller_ style, resulting in a disjointed accumulation of unrelated functionality. Resist that temptation - try to write reusable controllers.

Below is a shortened juxtaposition of what that could look like.

Bad
{: .label .label-red }

```html
<!-- page.html -->
<div data-controller="page">
  <form action="/" data-target="page.form"></form>
  <div data-target="page.modal" class="modal"></div>
</div> 
```
{: .border-red}

```js
// page_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form"];

  openModal() {
    this.modalTarget.classList.add("open");
  }

  submitForm() {
    this.formTarget.submit();
  }
}
```
{: .border-red}

Good
{: .label .label-green }

```html
<!-- page.html -->
<div>
  <form action="/" data-controller="form"></form>
  <div data-controller="modal" class="modal"></div>
</div> 
```
{: .border-green}

```js
// modal_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  open() {
    this.element.classList.add("open");
  }
}
```
{: .border-green}

```js
// form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit() {
    this.element.submit();
  }
}
```
{: .border-green}

### Rationale
Books have been written about this very single topic, but let it be said that classes/modules that serve a single responsibility are

1. **easy to reuse** - in our example above the `page_controller` can only be used on this very page (or one with the same structure), whereas `modal_controller` and `form_controller` could be used on any modal or form element, and
2. **easy to change** - because every responsibility has a single point of realization, changes are cheap: instead of having to implement a new functionality in several places, there's only one spot where you have to install the new behavior.

### Reference
- [Practical Object Oriented Design](https://www.poodr.com/) by Sandi Metz
- [Wikipedia](https://en.wikipedia.org/wiki/Single_responsibility_principle)
