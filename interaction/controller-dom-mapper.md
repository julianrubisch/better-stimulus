---
title: Controller DOM Mapper
parent: Interaction
nav_order: 1
---

# Controller DOM Mapper

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }


## Pain Point
- You're trying to access the internal state of a controller from outside of that controller
- Your controller needs to call a method on another controller

For example, suppose for your controller to do its job, it needs to know what page it is on from another controller:

```html
<!-- index.html -->
<div data-controller="pagination test" data-pagination-page="1">
  <button data-action="test#calculateRouteFromPage">Calculate Route From Page</button>
</div>
```

Warning
{: .label .label-yellow }

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

  calculateRouteFromPage() {
    const page = this.paginationController.page;
    // ... retrieve records etc...
  }
}
```
{: .border-yellow}

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
  calculateRouteFromPage() {
    const page = this.element.pagination.page;
    // ... retrieve records etc...
  }
}
```
{: .border-green}

### Rationale
Depending on undocumented APIs such as `getControllerForElementAndIdentifier` always implies the danger of things breaking in the (near) future. Attaching the controller simply to its element via `this.element[this.identifier] = this` removes this dependency in favor of an explicit reference to a specific controller instance. Because Stimulus uses `MutationObserver`s, you can be confident that `connect` will even hook up this reference correctly if the controller is added dynamically, either by your own Javascript code or some 3rd party library.

### Contraindications
If you have controller identifiers that contain invalid JS characters (`-`, ...), you will have to find a way to produce JS-compliant identifers, e.g. by camel-casing them as outlined in the blog post below. Also, be sure you don't overwrite an existing property such as `value`.

Another caveat to be mentioned here is that since controllers are attached to the DOM, potentially any JS code running in the scope of `document` can get hold of it, and execute methods defined on it. So exercise common sense in the decision of which controllers you want to expose in this fashion. Depending on your use case you might want to skip those executing destructive actions.

### Reference
- [Stimulus Power Move](https://leastbad.com/stimulus-power-move)
