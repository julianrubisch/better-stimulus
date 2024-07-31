---
layout: article
title: Open-Closed Principle
category: solid
preview_text: 
author: julianrubisch
cache: true
new: true
---

Good software design is - in part - realized by the capability to _**introduce changes**_ in a way that isn't painful. (If you'd like to read up on code smells that violate this principle, take a look at this [list of change preventers](https://refactoring.guru/refactoring/smells/change-preventers).)

The open-closed principle is a guideline that, if adhered to, makes this simple: Software entities should be

- **closed** for modification, but
- **open** to extension.

What does that mean? Let's look at an example:

Bad
{: .label .label-red }

```js
export default class WidgetController extends Controller {
  static values = { type: String, toggled: Boolean };

  async connect() {
    switch(this.typeValue) {
      case "toggle":
        this.toggledValue = false;
        break;
      case "dropdown":
        this.options = await fetch(`...`);
        break;
    }
  }
}
{: .border .border-red }
```

Trivial as this case may be, consider what it would entail to add a new type of widget, say a `slider`? Correct, we'd have to add a new `case` clause each time, further diluting the class's state (`typeValue`, `options`) with new properties.

What's more, if there were child classes of `WidgetController`, they'd be exposed to the risk of breaking whenever `connect` is altered.

Good
{: .label .label-green }

```js
// Base controller for UI widgets
export default class WidgetController extends Controller {
  connect() {
    this.setup();
  }
}

export default class ToggleController extends WidgetController {
  static values = { toggled: Boolean };

  setup() {
    super.setup();
    this.toggledValue = false;
  }
}

export default class DropdownController extends WidgetController {
  async setup() {
    super.setup();
    this.options = await fetch(`...`);
  }
}
{: .border .border-green }
```

Contrast this to the example above: A specialized `setup()` method is overridden in the individual widget classes. The state definitions are private to the child classes, so that adding new widgets is as simple as adding a new class that inherits from `WidgetController`.

Omitted here, but common practice, are method definitions in the base class that are to be polymorphically overridden in the descendants - think `disabled()` etc.

### Reference
- [Wikipedia](https://en.m.wikipedia.org/wiki/Open%E2%80%93closed_principle)
