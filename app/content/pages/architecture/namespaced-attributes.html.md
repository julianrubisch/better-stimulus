---
layout: article
title: Namespaced Attributes
category: architecture
preview_text: We might want to work with an arbitrary set of attributes that are namespace not just to the controller but identified as parameters.
author: leastbad
cache: true
---

Good
{: .label .label-green}

```html
<!-- index.html -->
<input data-controller="filter" data-filter-param-category="cats" data-filter-param-rating="5" data-filter-param-color="black" type="text" data-action="input->filter#update">
{: .border .border-green}
```

```js
// filter_controller.js
import { Controller } from "@hotwired/stimulus";

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
{: .border .border-green}
```

### Rationale
Building on the [Configurable Controllers](../architecture/configurable-controllers) example, we might want to work with an arbitrary set of attributes that are namespace not just to the controller but identified as parameters.

Unfortunately, Stimulus doesn't make it easy to obtain a list of available attributes, or specify further namespace criteria. Bypassing the Stimulus `data` accessor entirely, we first convert the controller element's dataset to a JS object before emitting an array of its' keys. We retain only the attributes named `data-filter-param-*` and then strip those attributes down to their base names for inclusion in the URL querystring.

**Note**: you'll need to adjust the value passed to `slice` to account for the length of your controller's identifier.

<!-- ### Codesandbox Example -->

<!-- <iframe -->
<!--      src="https://codesandbox.io/embed/sweet-chaum-o8ry2?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Ffilter_controller.js&theme=dark" -->
<!--      style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" -->
<!--      title="sweet-chaum-o8ry2" -->
<!--      allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking" -->
<!--      sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts" -->
<!--    ></iframe> -->
