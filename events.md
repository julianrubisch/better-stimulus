---
title: Events
---

# Events

## Register Global Events in Your Markup

### BAD
```js
initialize() {
  document.addEventListener(...);
}
```

### GOOD
```js
successHandler(e) {
}
```

### Rationale


