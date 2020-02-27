---
title: Controller DOM Mapper
parent: Interaction
nav_order: 1
---

# Controller DOM Mapper

```html
<div data-controller="pagination test" data-pagination-page="1">
  <button data-action="test#doSomething">Do Something</button>
</div>
```

Bad
{: .label .label-red }

```js
// pagination_controller.js
export default class extends Controller {
  get page() {
    return this.data.get("page");
  }
}

// test_controller.js
export default class extends Controller {
  connect() {
    this.paginationController = this.application.getControllerForElementAndIdentifier(
      this.element,
      "pagination"
    );
  }

  doSomething() {
    const page = this.paginationController.page;
    // ... retrieve records etc...
  }
}
```
{: .border-red}

Good
{: .label .label-green }

```js
// pagination_controller.js
export default class extends Controller {
  connect() {
    this.element[this.identifier] = this;
  } 

  get page() {
    return this.data.get("page");
  }
}

// test_controller.js
export default class extends Controller {
  doSomething() {
    const page = this.element.pagination.page;
    // ... retrieve records etc...
  }
}
```
{: .border-green}

### Rationale
Depending on undocumented APIs such as `getControllerForElementAndIdentifier` always implies the danger of things breaking in the (near) future. Attaching the controller simply to its element via `this.element[this.identifier] = this` removes this dependency in favor of an explicit reference to a specific controller instance. Because Stimulus uses `MutationObserver`s, you can be confident that `connect` will even hook up this reference correctly if the controller is added dynamically, either by your own Javascript code or some 3rd party library.

### Contraindications
If you have longish controller names, you will have to find a way to produce JS-compliant identifers, e.g. by camel-casing them as outlined in the blog post below. Another caveat to be mentioned here is that since controllers are attached to the DOM, potentially any JS code running in the scope of `document` can get hold of it, and execute methods defined on it. So exercise common sense in the decision of which controllers you want to expose in this fashion. Depending on your use case you might want to skip those executing destructive actions.

### Reference
- [Stimulus Power Move](https://leastbad.com/stimulus-power-move)
