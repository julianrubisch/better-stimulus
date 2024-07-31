---
layout: article
title: Outlets
category: interaction
preview_text: Send messages between controllers using the Stimulus Outlets API
author: julianrubisch
cache: true
---

Inter-process communication has been a source of many band-aids in the past. Luckily with [outlets](https://stimulus.hotwired.dev/reference/outlets) we now have an official way to invoke logic across controller boundaries.

Good
{: .label .label-green }

```html
<body
    data-controller="job-dashboard"
    data-job-dashboard-job-outlet=".job"
  >
  <button data-action="job-dashboard#refresh"></button>
  <ul>
    <li data-controller="job" class="job"></li>
  </ul>
</body>
{: .border .border-green }
```

```js
// job_dashboard_controller.js
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static outlets = ['job'];
  
  refresh() {
    this.jobOutlets.forEach((outlet) => {
      outlet.update({...})
    });
  }
}

// job_controller.js
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  update(data) {
    // ...
  }
}
{: .border .border-green }
```

### Rationale
You have split your controllers according to the [Single Responsibility Principe](../solid/single-responsibility), and now want to send messages from one to another. This can occur, for example, in data-rich complex UIs like dashboards, data tables, media elements etc.

### Contraindications
Tracking outlets via their selectors in the HTML can be tedious. The markup can become bloated and confusing. So I'd advise to use it sparingly, and look into [custom events](https://stimulus.hotwired.dev/reference/controllers#cross-controller-coordination-with-events) as an alternative.
