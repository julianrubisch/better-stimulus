---
title: Events
nav_order: 4
---

# Events

## Register Global Events in Your Markup

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }


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

### Reference
- [https://stimulusjs.org/reference/actions](https://stimulusjs.org/reference/actions)
- [Stimulus EventListener on Github](https://github.com/stimulusjs/stimulus/blob/master/packages/@stimulus/core/src/event_listener.ts)
- [Stimulus Dispatcher on Github](https://github.com/stimulusjs/stimulus/blob/master/packages/@stimulus/core/src/dispatcher.ts)


