---
title: Global Error Handler
parent: Error Handling
---

# Global Error Handler

#### by @adrienpoly {% avatar adrienpoly size=24 %}

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
```

