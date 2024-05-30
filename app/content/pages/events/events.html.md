---
title: Events
category: events
---

# Events

### Register Global Events in Your Markup

<!-- #### by @julianrubisch {% avatar julianrubisch size=24 %} -->
<!-- {: .fs-3 } -->


Bad
{: .label .label-red }

```js
connect() {
  document.addEventListener(...);
}
```
{: .border-red }

Good
{: .label .label-green }

```html
<div data-controller="gallery" data-action="resize@window->gallery#layout">...</div>
```
{: .border-green }

```js
layout(e) {
  ...
}
```
{: .border-green }

### Rationale
Stimulus will handle the adding and removing of event listeners.

### Contraindications
The controller code makes assumption about the markup, which may not be feasible if you're creating a Stimulus controller library. In this case, be sure to unregister your event listeners in `disconnect`.

### Why does this happen?

A stimulus controller can `connect` / `disconnect` an arbitrary number of times. If eventListeners added in `connect` are not cleaned up on `disconnect`, you will have more than one eventListener for the given element and thus run your event listener callback multiple times instead of just once.

## How to cleanup event listeners in connect / disconnect

Bad
{: .label .label-red }

```js
connect() {
  document.addEventListener("click", this.findFoo.bind(this))
}

disconnect() {
  document.removeEventListener("click", this.findFoo.bind(this))
}

findFoo() {
  console.log(this.element.querySelector("#foo"))
}
```
{: .border-red }

Good
{: .label .label-green }

```js
connect() {
  this.boundFindFoo = this.findFoo.bind(this)
  document.addEventListener("click", this.boundFindFoo)
}

disconnect() {
  document.removeEventListener("click", this.boundFindFoo)
}

findFoo() {
  console.log(this.element.querySelector("#foo"))
}
```
{: .border-green }



### Why is the first one bad?

When you call `.bind()` on a function, it creates a new function. Therefore, calling bind twice means the 
add and remove eventListeners are calling different references of the function and the event wont be removed.
Make sure that when adding and removing event listeners you use the same bound function reference.

### Reference
- [https://stimulus.hotwired.dev/reference/actions](https://stimulus.hotwired.dev/reference/actions)
- [Stimulus EventListener on GitHub](https://github.com/hotwired/stimulus/blob/main/src/core/event_listener.ts)
- [Stimulus Dispatcher on GitHub](https://github.com/hotwired/stimulus/blob/main/src/core/dispatcher.ts)
- [Function Bind - MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind)


