---
title: Global Error Handler
parent: Error Handling
---


Updated for Stimulus 2
{: .label .label-purple }

# Global Error Handler

#### by @adrienpoly {% avatar adrienpoly size=24 %}
{: .fs-3 }

## Pain Point

You want to catch errors pertaining to Stimulus (`connect` errors, `targets` not being accessible etc.) as well as application errors within your controllers and send them to an error tracking service of your choice (e.g. Sentry, Honeybadger etc.).

## Solution

First define a [global Application Controller](../architecture/application-controller.md) that your Stimulus controllers will inherit from.

Within this ApplicationController define a new `handleError` function. Here this function creates a small context object with the id of the current user (you can pass all context information that can help you debug: environment, subscription status, etc).

Stimulus includes a largely undocumented error handler (see links below). By default, this error handle catches all Stimulus internal errors and output a prettified `console.log`.

Within our `handleError` function we can call this `application.handleError` with our custom context to have a single function being responsible to manage and report errors.

{: .border-green}

```js
// app/javascript/controllers/application_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends ApplicationController {
  handleError = (error) => {
    const context = {
      controller: this.identifier,
      user_id: this.userId,
    };
    this.application.handleError(
      error,
      `Error in controller: ${this.identifier}`,
      context
    );
  };

  get userId() {
    return this.metaValue("user_id");
  }
}
```

In your controllers now you can catch errors and pass them to `this.handleError` for reporting.

{: .border-green}

```js
// app/javascript/controllers/some_controller.js

export default class extends ApplicationController {
  someFunc() {
    try {
      // ...
    } catch (err) {
      this.handleError(err);
    }
  }
}
```

### Adding a reporting service

Here is an example to configure Sentry for reporting Stimulus errors :

{: .border-green}

```js
// app/javascript/packs/application.js
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

// memorize default handler
const defaultErrorHandler = application.handleError.bind(application);

// configure Sentry to log errors and prepend the default handler
const sentryErrorHandler = (error, message, detail = {}) => {
  defaultErrorHandler(error, message, detail);
  Sentry.captureException(error, { message, ...detail });
};

// overwrite the default handler with our new composed handler
application.handleError = sentryErrorHandler;
```

This new instrumented handler will now send global errors to Sentry. The example above shows how you can furthermore use this function to catch errors in our own application code in `try/catch` blocks.

### Rationale

The rationale behind all this, is to have a single error handler for all errors within a Stimulus Controller. Whether they are Stimulus or application errors they all go through the same path. Once this unique handler is in place it is easy to add context to the error message and dispatch errors to various reporting systems such as Sentry, [Honeybadger](https://docs.honeybadger.io/lib/javascript/integration/stimulus.html) or others.

### References

- [Github issue discussing the internals of calling application code from Stimulus](https://github.com/stimulusjs/stimulus/issues/236)
- [Github PR introducing the error handler](https://github.com/stimulusjs/stimulus/pull/53)
