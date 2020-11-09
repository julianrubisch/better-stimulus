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

// memorize default handler
const defaultErrorHandler = application.handleError

// configure Sentry to log errors and prepend the default handler
const sentryErrorHandler = (error, message, detail = {}) => {
  defaultErrorHandler(error, message, detail)
  Sentry.captureException(error, { message, ...detail })
}

// overwrite the default handler with our new composed handler
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
Stimulus includes a largely undocumented global error handler (see links below) that catches errors when Stimulus invokes your application code in internal `try/catch` blocks. This error handler does little more than prettify `console.log` output.

We can, hover, hook into it by first memorizing the default handler:

```js
const defaultErrorHandler = application.handleError
```

and then provide our own implementation:

```js
const sentryErrorHandler = (error, message, detail = {}) => {
  defaultErrorHandler(error, message, detail)
  Sentry.captureException(error, { message, ...detail })
}
```

This new instrumented handler will now send global errors to Sentry. The example above shows how you can furthermore use this function to catch errors in our own application code in `try/catch` blocks.

### References
- [Github issue discussing the internals of calling application code from Stimulus](https://github.com/stimulusjs/stimulus/issues/236)
- [Github PR introducing the error handler](https://github.com/stimulusjs/stimulus/pull/53)
