---
title: Architecture
nav_order: 2
---

# Architecture

## Application Controller

Good
{: .label .label-green}

### `application_controller.js`
```js
import { Controller } from "stimulus";

export default class extends Controller {
  sayHi () {
    console.log("Hello from the Application controller.");
  }
}
```
{: .border-green}

### `custom_controller.js`
```js
import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  sayHi () {
    super();
    console.log("Hello from a Custom controller");
  }
}
```
{: .border-green}

### Rationale
You can make use of JavaScript's class inheritance to set up an "Application Controller" that will serve as the foundation for all of your controllers to build upon. This not only reduces boilerplate, but it's also a convenient way to set up lifecycle callback methods for your entire application.

### Counterindications
Inheritance isn't always the answer to share behavior. Before bloating your `ApplicationController`, ask yourself if what you're implementing isn't a specialization but a [role](https://en.wikipedia.org/wiki/Data,_context_and_interaction) (use mixins) or a collaborator (use composition).

### References
- Courtesy of [https://docs.stimulusreflex.com/patterns](https://docs.stimulusreflex.com/patterns)
