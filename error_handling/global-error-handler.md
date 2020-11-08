---
title: Global Error Handler
parent: Error Handling
---

# Global Error Handler

#### by @adrienpoly {% avatar adrienpoly size=24 %}
{: .fs-3 }

## Pain Point
You want to catch errors pertaining to Stimulus (`connect` errors, `targets` not being accessible etc.) and send them to an error tracking service of your choice (e.g. Sentry, Honeybadger etc.). 

```js
// app/javascript/packs/application.js
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))


// configure Sentry to log errors
const defaultErrorHandler = application.handleError

const sentryErrorHandler = (error, message, detail = {}) => {
  defaultErrorHandler(error, message, detail)
  Sentry.captureException(error, { message, ...detail })
}

application.handleError = sentryErrorHandler
```
{: .border-green}

```js
// app/javascript/controllers/application_controller.js
import { Controller } from "stimulus"

export default class extends ApplicationController {
  handleError = error => {
    const context = {
      controller: this.identifier,
      user_id: this.userId,
    }
    this.application.handleError(error, `Error in controller: ${this.identifier}`, context)
  }
  
  get userId() {
    return this.metaValue('user_id')
  }
}
```
{: .border-green}

```js
// app/javascript/controllers/some_controller.js

export default class extends ApplicationController {
  someFunc() {
    try {
      // ...
    } catch (err) {
      this.handleError(err)
    }
  }
}
```
{: .border-green}

### Rationale

### References
- [Github issue discussing the internals of calling application code from Stimulus](https://github.com/stimulusjs/stimulus/issues/236)
- [Github PR introducing the error handler](https://github.com/stimulusjs/stimulus/pull/53)
