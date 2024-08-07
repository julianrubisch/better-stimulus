---
layout: article
title: Dependency Inversion Principle
category: solid
preview_text: 
author: julianrubisch
cache: true
new: true
---

The main purpose of the **Dependency Inversion Principle** is to provide loose coupling between software modules, summarized by the epitome "depend upon abstractions, not concretes".

But what does that mean in practice, and how can it be applied to Stimulus?

To start, let's conceive a simple controller wrapping an imaginary search API:

Bad
{: .label .label-red }

```js
// SearchAPI.js
class SearchAPI {
  search(query) {
    // Simulating an API call
    return fetch(`https://api.example.com/search?q=${query}`)
      .then(response => response.json());
  }
}

// search_controller.js
import { Controller } from "@hotwired/stimulus"
import { SearchAPI } from "./SearchAPI"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.searchAPI = new SearchAPI()
  }

  search() {
    // perform search
    this.searchAPI.search(...)
  }
}
{: .border .border-red }
```

Why is this bad? Well, because the search controller's internal reference is tightly coupled to a specific module (`SearchAPI`). In other words, if we were to add another search service (say, Algolia) to our application, we have no choice but to introduce a second controller (`algolia_controller`). Welcome, [shotgun surgery](https://refactoring.guru/smells/shotgun-surgery)!

To avoid this, in classic object oriented design, you'd **inject the dependency** at creation time:

```js
new SearchController(new SearchAPI())
new SearchController(new AlgoliaAPI())
```

Now, in Stimulus we cannot do this, because controllers are instantiated by the application as needed (a nice example of another principle, [**inversion of control**](https://en.wikipedia.org/wiki/Inversion_of_control), by the way). In other words, all creation arguments have to be passed by serialized data attributes in the DOM.

But there's still a way we can enhance the situation using Stimulus values and [dynamic imports](https://dev.to/adrienpoly/dynamic-module-import-with-stimulus-js-297g). Observe:

Good
{: .label .label-green }

```js
// GoogleAPI.js
class GoogleAPI {
  // ...
}

// AlgoliaAPI.js
class AlgoliaAPI {
  // ...
}

// search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { api: String }

  async apiValueChanged(apiValue) {
    if(apiValue === "google") {
      this.searchAPI = await import("./GoogleAPI");
    } else if(apiValue === "algolia") {
      this.searchAPI = await import("./AlgoliaAPI");
    }
  }

  search() {
    // perform search
    this.searchAPI.search(...)
  }
}
{: .border .border-green }
```

```html
<div data-controller="search" data-search-api-value="google">...</div>
<div data-controller="search" data-search-api-value="algolia">...</div>
{: .border .border-green }
```

### Rationale

In the code above, when the `api` value changes (which it does on first load, for example), the `searchAPI` dependency is loaded via a dynamic import. Thus, we can use an `if` statement to determine which one to load (and potentially add more in the future). It even allows you to switch values at runtime!

Yes, by introducing a conditional we have added some complexity to the controler class, but we have still introduced a single point of change should you want to add additional dependencies in the future. Thus, coupling has been significantly reduced an to add another service, you just have to conform to that module's interface (i.e., provide a `search` method) and add a conditional clause.


### Reference
- [Wikipedia](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
