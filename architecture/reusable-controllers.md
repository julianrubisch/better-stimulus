---
title: Reusable Controllers
nav_order: 3
parent: Architecture
---

# Reusable Controllers


Bad
{: .label .label-red}

```html
<!-- index.html -->
<input data-controller="category-filter" type="text" data-action="input->categoryFilter#filter">
```
{: .border-red}

```js
// category_filter_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  filter () {
      const url = new URL(window.location)
      url.searchParams.set('category', this.element.value)
      history.pushState({}, '', url.toString())
  }
}
```
{: .border-red}

Good
{: .label .label-green}

```html
<!-- index.html -->
<input data-controller="filter" data-filter-param="category" type="text" data-action="input->filter#update">
```
{: .border-green}

```js
// filter_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  update () {
    const url = new URL(window.location)
    url.searchParams.set(this.data.get('param'), this.element.value)
    history.pushState({}, '', url.toString())
  }
}
```
{: .border-green}

### Rationale
We all have a forgiveable tendency to build one-off controllers to solve immediate problems without concern for future reusability. Indeed, there is a strong argument to be made against premature optimization and you don't want to increase your development time to account for reuse that will never occur.

While every project and situation is unique, Stimulus does make it easy to design for basic reuse by default, without adding any boilerplate code or overhead, by making it easy to access data atttributes instead of hard-coding values that make reuse impossible.

Using the Stimulus `data` accessor, we can obtain an attribute's value. Attribute keys are namespaced to the controller identifier. In this case `data-filter-param` is accessed via `this.data.get('param')`.
