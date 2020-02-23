---
title: Events
nav_order: 3
---

# Events

## Register Global Events in Your Markup

Bad
{: .label .label-red }

```js
initialize() {
  document.addEventListener(...);
}
```
{: .border-red }

Good
{: .label .label-green }

```js
successHandler(e) {
}
```
{: .border-green }

### Rationale


