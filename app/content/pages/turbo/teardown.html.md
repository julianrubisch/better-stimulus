---
layout: article
title: Global Teardown
category: turbo
preview_text: In a Stimulus controller, typically disconnect is concerned with teardown code, however, it could be argued that the general lifecycle callbacks should be kept free of any code that’s not concerned with the controller and its elements per se. With Turbo-related teardown logic getting its own lifecycle method, there’s exactly one place where that rollback should happen, and every controller can opt in to this behavior, or not.
authors: 
  - leastbad
  - adrienpoly
cache: true
---

### Pain Point
Turbo caches a page's state before navigating away. If you access the page again, it first displays the cached version as a preview, then refreshes the content.

Any transitional changes to the state before caching will thus lead to a flash of manipulated content.

To fix this situation, add a `teardown` method to any controller that manipulates the DOM and needs to roll its changes back. Using the following snippet, placed for example in your `app/javascript/packs/application.js`, you can globally reset the state of every controller which implements this method.

```js
// app/javascript/application.js
document.addEventListener('turbo:before-cache', () => {
  application.controllers.forEach(controller => {
    if (typeof controller.teardown === 'function') {
      controller.teardown()
    }
  })
})
{: .border .border-green}
```

```js
// app/javascript/controllers/any_controller.js
export default class extends Controller {
  connect() {
    // ...
  }

  teardown() {
    this.element.classList.remove('play-animation')
  }
}
{: .border .border-green}
```

### Rationale

In a Stimulus controller, typically `disconnect` is concerned with teardown code, however, it could be argued that the general lifecycle callbacks should be kept free of any code that's not concerned with the controller and its elements per se. With Turbo-related teardown logic getting its own lifecycle method, there's exactly one place where that rollback should happen, and every controller can opt in to this behavior, or not.

### Contraindications
There's something to say about the necessity of adding another teardown method, when all Stimulus controllers already come with a built-in `disconnect` function. You might not want to duplicate this behavior, probably depending on the intensity of Turbo usage in your application, and how Turbo-related teardown logic differs from other similar concerns.


### References
- [https://dev.to/adrienpoly/animations-with-turbolinks-and-stimulus-4862](https://dev.to/adrienpoly/animations-with-turbolinks-and-stimulus-4862)
