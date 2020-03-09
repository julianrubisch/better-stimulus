---
title: Namespaced Attributes
nav_order: 4
parent: Architecture
---

# Namespaced Attributes

Good
{: .label .label-green}

```html
<!-- index.html -->
<input data-controller="filter" data-filter-param-category="cats" data-filter-param-rating="5" data-filter-param-color="black" type="text" data-action="input->filter#update">
```
{: .border-green}

```js
// filter_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  update () {
    const url = new URL(window.location)
    Object.keys(Object.assign({}, this.element.dataset))
      .filter(attr => attr.startsWith("filterParam"))
      .forEach(attr => {
        url.searchParams.set(
          attr.slice(11).replace(/^\w/, c => c.toLowerCase()),
          this.element.dataset[attr]
        )
      })
    history.pushState({}, '', url.toString())
  }
}
```
{: .border-green}

### Rationale
Building on the [Reusable Controllers](https://www.betterstimulus.com/architecture/reusable-controllers.html) example, we might want to work with an arbitrary set of attributes that are namespace not just to the controller but identified as parameters.

Unfortunately, Stimulus doesn't make it easy to obtain a list of available attributes, or specify further namespace criteria. Bypassing the Stimulus `data` accessor entirely, we first convert the controller element's dataset to a JS object before emitting an array of its' keys. We retain only the attributes named `data-filter-param-*` and then strip those attributes down to their base names for inclusion in the URL querystring.

**Note**: you'll need to adjust the value passed to `slice` to account for the length of your controller's identifier.
