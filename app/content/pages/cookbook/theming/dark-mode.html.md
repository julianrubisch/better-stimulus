---
layout: cookbook
title: Dark Mode
category: theming
preview_text: 
stackblitz_url: https://stackblitz.com/edit/better-stimulus-dark-mode?file=index.html,controllers%2Fdark_mode_controller.js&embed=1
code: |
  import { Controller } from '@hotwired/stimulus';
  
  export default class extends Controller {
    static classes = ['light', 'dark'];
    static values = { colorScheme: String };
  
    initialize() {
      if ('colorScheme' in localStorage) {
        this.colorSchemeValue = localStorage.colorScheme;
      }
  
      // to listen for "system setting" changes
      window
        .matchMedia('(prefers-color-scheme: dark)')
        .addEventListener('change', this.#dispatchChange);
    }
  
    toggle(event) {
      this.colorSchemeValue = event.target.value;
    }
  
    async colorSchemeValueChanged() {
      localStorage.colorScheme = this.colorSchemeValue;
  
      // wait for next frame
      await new Promise(requestAnimationFrame);
  
      this.#dispatchChange();
    }
  
    updateColorScheme(event) {
      const { colorScheme } = event.detail;
  
      this.darkClasses.forEach((darkClass) => {
        document.documentElement.classList.toggle(
          darkClass,
          this.#isDark(colorScheme)
        );
      });
  
      this.lightClasses.forEach((lightClass) => {
        document.documentElement.classList.toggle(
          lightClass,
          !this.#isDark(colorScheme)
        );
      });
    }
  
    #isDark(colorScheme) {
      if (colorScheme === 'auto') {
        return window.matchMedia('(prefers-color-scheme: dark)').matches;
      }
  
      return colorScheme === 'dark';
    }
  
    #dispatchChange = () => {
      this.dispatch('change', { detail: { colorScheme: this.colorSchemeValue } });
    };
  }
author: julianrubisch
cache: true
new: false
---

### Configuration

|Attribute|Default|Description|Required|
|---------|-------|-----------|--------|
|`data-dark-mode-light-class`| - | Name of the light theme class to be toggled on the `<html>` element | yes |
|`data-dark-mode-dark-class` | - | Name of the dark theme class to be toggled on the `<html>` element | yes |


### Implementation

The core of the implementation is a `colorScheme` Stimulus value, that is set both when the controller initializes, or the `toggle` action is called.

After it is set, the current color scheme is stored in `localStorage` and a custom `change` event is being dispatched.

This event is caught in the `dark-mode:change->dark-mode#updateColorScheme` action put on the `body` tag. This method finally toggles the supplied light/dark classes on the `html` element.

The rationale for this architecture is that this scheme change event can then be listened for and utilized elsewhere (see below).

Notable prior art:

- [Implementing Dark Mode in Your Rails 7 App with Tailwind and Stimulus JS](https://arthurariza.hashnode.dev/bringing-elegance-to-the-night-implementing-dark-mode-in-your-rails-7-app-with-tailwind-and-stimulus-js#heading-stimulus-js)

### Customization

First of all, the controller assumes that the theme CSS class is attached to the root `<html>` element. Most CSS frameworks adhere to this, but if yours is different, you'll need to make adjustments.

Second, depending on how you implement your theme switcher widget, you'll want to customize the `toggle` method. This implementation assumes that it's a radio group and uses its `value` attribute.

Finally, this controller **does not** handle updating of the widget, since that would be beyond its responsibility. It **does** emit the `change` event though (both on connect and whenever the theme value is changed), so you can listen for this event in any other Stimulus, controller, e.g.:

```html
<input type="radio" name="theme"
  data-action="dark-mode:change->radio#updateSelection" />
```

### Gotchas

Implementing this controller will still lead to a flash of white when opening a page. That's because of Stimulus' lifecycle that only starts once the DOM has been rendered and parsed.

To overcome this, add a blocking script like this to your application layout:

```js
function isDark(colorScheme) {
  if (colorScheme === "auto") {
    return window.matchMedia("(prefers-color-scheme: dark)").matches;
  }

  return colorScheme === "dark";
}

if("colorScheme" in localStorage) {
  document.documentElement.classList.toggle("sl-theme-dark", isDark(localStorage.colorScheme));

  document.documentElement.classList.toggle("sl-theme-light", !isDark(localStorage.colorScheme));
}
```

### Dark Mode in the Wild

- [Tailwind](https://tailwindcss.com/docs/dark-mode#supporting-system-preference-and-manual-selection)
- [Bootstrap](https://getbootstrap.com/docs/5.3/customize/color-modes/#dark-mode)
- [Bulma](https://bulma.io/documentation/features/dark-mode/)
- [PhlexUI](https://phlexui.com/docs/dark_mode)
- [Shoelace](https://shoelace.style/getting-started/themes#dark-theme)
- [Flowbite](https://flowbite.com/docs/customize/dark-mode/#content)
