---
title: Application Controller
category: architecture
---

# Application Controller

<!-- #### by @julianrubisch {% avatar julianrubisch size=24 %} -->
<!-- {: .fs-3 } -->


Good
{: .label .label-green}

```js
// application_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  sayHi () {
    console.log("Hello from the Application controller.");
  }
}
```
{: .border-green}

```js
// custom_controller.js
import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  sayHi () {
    super.sayHi();
    console.log("Hello from a Custom controller");
  }
}
```
{: .border-green}

### Rationale
You can make use of JavaScript's class inheritance to set up an "Application Controller" that will serve as the foundation for all of your controllers to build upon. This not only reduces boilerplate, but it's also a convenient way to set up lifecycle callback methods for your entire application.

### Counterindications
Inheritance isn't always the answer to share behavior. Before bloating your `ApplicationController`, ask yourself if what you're implementing isn't a specialization but a [role](https://en.wikipedia.org/wiki/Data,_context_and_interaction) (has a "acts as a" relationship to your class - use [mixins](./mixins.md)) or a attributes or property (has a "has a" relationship to your class - use [composition](https://en.wikipedia.org/wiki/Composition_over_inheritance)).

### References
- Courtesy of [https://docs.stimulusreflex.com/patterns](https://docs.stimulusreflex.com/patterns)

### Codesandbox Example
<iframe
     src="https://codesandbox.io/embed/practical-shockley-lo5ns?fontsize=14&hidenavigation=1&module=%2Fsrc%2Fcontrollers%2Fexample_controller.js&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="practical-shockley-lo5ns"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-autoplay allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
