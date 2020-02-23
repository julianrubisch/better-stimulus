---
title: Events
nav_order: 3
---

# Events

## Register Global Events in Your Markup

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

### Reference
- [https://stimulusjs.org/reference/actions](https://stimulusjs.org/reference/actions)
- [Stimulus EventListener on Github](https://github.com/stimulusjs/stimulus/blob/master/packages/@stimulus/core/src/event_listener.ts)
- [Stimulus Dispatcher on Github](https://github.com/stimulusjs/stimulus/blob/master/packages/@stimulus/core/src/dispatcher.ts)


