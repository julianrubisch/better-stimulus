---
layout: article
title: Use Callbacks to Communicate Between Controllers
category: interaction
preview_text: Your code may grow to the point where you’ll have a lot of controllers needing data from other controllers. You could write multiple event triggers to link them all up together, but this would be redundant and inefficient.
author: geetfun
---

# Use Callbacks to Communicate Between Controllers

- You want to maintain a set of logic in a single StimulusJS component
- You need the value from another controller to perform your function
- You do not want to create multiple events to handle all the possible cases

For simplicity's sake (without needing use custom event constructors), the examples below use jQuery. However, you could use plain JavaScript as well.

Bad
{: .label .label-red }

```js
// first_controller.js
export default class extends Controller {
  setName(value) {
    this.name = value
    $(document).trigger('first_controller.nameChanged', this.name)
  }
}

// second_controller.js
export default class extends Controller {
  connect() {
    // In this controller, we need the name to render our UI in some way
    $(document).on('first_controller.nameChanged', function(event, name) {
      // Your code to do something with the name
      this.name = name
    }.bind(this))
  }
}
```
{: .border-red }

Good
{: .label .label-green }

```js
// first_controller.js
export default class extends Controller {
  connect() {
    $(document).on('first_controller.state', function(event, callback) {
        callback(this)
      }.bind(this)
    )
  }
  
  setName(value) {
    this.name = value
  }
}

// second_controller.js
export default class extends Controller {
  render() {
    $(document).trigger('first_controller.state', function(firstController) {
      // Your code to get the first controller state/data
      this.name = firstController.name
      // Your code to handle your UI rendering that is specific to the second controller
    })
  }
}
```
{: .border-green }

### Rationale
Your code may grow to the point where you'll have a lot of controllers needing data from other controllers. You could write multiple event triggers to link them all up together, but this would be redundant and inefficient.

The controller with the data should not have to trigger an event for all these instances. Instead, you can use the above method to allow each controller to return itself to a callback. 

### Counterindications
The purpose of the callback should be clear in your design. For instance, you do not want to abuse this method to trigger actions from other controllers. This would defeat the design of StimulusJS where each controller handles a single component. However, if you must communicate between controllers in some way, this method cleans up your code and provides a common interface (ie. message bus design pattern).

### References
[https://rails.substack.com/p/stimulusjs-finding-out-the-state](https://rails.substack.com/p/stimulusjs-finding-out-the-state)
