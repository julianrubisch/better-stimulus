---
title: Single Responsibility Principle
parent: SOLID
---

# Single Responsibility Principle

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
import { Controller } from "stimulus";

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
import { Controller } from "stimulus";

export default class extends Controller {
  open() {
    this.element.classList.add("open");
  }
}
```
{: .border-green}

```js
// form_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  submit() {
    this.element.submit();
  }
}
```
{: .border-green}

### Rationale

### Reference
- [Wikipedia](https://en.wikipedia.org/wiki/Single_responsibility_principle)
