---
layout: article
title: State Management with the Values API
category: architecture
preview_text: Use Stimulus values as the single source of truth for your controller state.
author: julianrubisch
cache: true
new: true
---

A question that often arises is how and where to store state in a Stimulus controller. The correct answer in 90% of all cases is in Stimulus [values](https://stimulus.hotwired.dev/reference/values).

Bad
{: .label .label-red }

```js
// map_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.map = new Map(this.element); // some map service
    this.markers = [];
  }
  
  addMarker() {
    this.markers.push({...})
    this.map.updateMarkers(this.markers);
  }
}
{: .border .border-red }
```

Good
{: .label .label-green }

```js
// map_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {markers: Array}
  
  connect() {
    this.map = new Map(this.element); // some map service
  }
  
  addMarker() {
    this.markersValue.push({...});
  }
  
  markersValueChanged(markers) {
    this.map.updateMarkers(markers);
  }
}
{: .border .border-green }
```

### Rationale
Stimulus values being serialized and stored in the DOM itself provides the single source of truth for the controller in question. This not only enables mutating state from outside (think via Turbo Streams or [Turbo Morphs](https://turbo.hotwired.dev/handbook/page_refreshes)), it also ties in neatly with [Turbo Caching](https://turbo.hotwired.dev/handbook/building#understanding-caching), for example.

### Contraindications
In some cases, controller state might not be serializable into one of the built-in [types](https://stimulus.hotwired.dev/reference/values#types). Other times, they might contain sensitive data that you do **not** want to be exposed in the HTML.
