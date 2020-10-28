---
title: Global Teardown
parent: With Turbolinks
---

# Global Teardown

#### by @leastbad {% avatar leastbad size=24 %}
{: .fs-3 }

## Pain Point
Turbolinks caches a page's state before navigating away. If you access the page again, it first displays the cached version as a preview, then refreshes the content.

Any transitional changes to the state before caching will thus lead to a flash of manipulated content.

To fix this situation, add a `teardown` method to any controller that manipulates the DOM and needs to roll its changes back. Using the following snippet, placed for example in your `app/javascript/packs/application.js`, you can globally reset the state of every controller which implements this method.

```js
// app/javascript/packs/application.js
document.addEventListener('turbolinks:before-cache', () => {
  application.controllers.forEach(controller => {
    if (typeof controller.teardown === 'function') {
      controller.teardown()
    }
  })
})
```
{: .border-green}

```js
// app/javascript/controllers/any_controller.js
export default class extends Controller {
  // ...

  teardown() {
    
  }
}
```
{: .border-green}
