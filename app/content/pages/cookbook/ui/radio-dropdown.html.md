---
layout: cookbook
title: Radio Dropdown
category: ui
preview_text: Use this controller to create a radio dropdown that allows users to toggle between options, update the displayed label based on the selected item, and emit a change event for further interaction.
stackblitz_url: https://stackblitz.com/edit/better-stimulus-radio-dropdown?file=index.html,controllers%2Fradio_dropdown_controller.js&embed=1
code: |
  import { Controller } from '@hotwired/stimulus';
  
  // Connects to data-controller="radio-dropdown"
  export default class extends Controller {
    static targets = ['label'];
    static values = {
      itemSelector: String,
    };
  
    updateSelection(event) {
      const value = event.detail.item.value; // <-- maybe change this
  
      this.items.forEach((item) => {
        item.checked = item.getAttribute('value') === value; // <-- expects a "checked" attribute on items
      });
  
      this.labelTarget.textContent = this.items.find(
        (item) => item.checked
      ).textContent;
  
      this.dispatch('change', { detail: { value } });
    }
  
    get items() {
      return [...this.element.querySelectorAll(this.itemSelectorValue)];
    }
  }
author: julianrubisch
auth: true
---

### Configuration

|Attribute|Default|Description|Required|
|---------|-------|-----------|--------|
|`data-radio-dropdown-item-selector-value`| - | Selector for dropdown item elements (e.g. `sl-menu-item`, `.item` etc.) | yes |

### Events

|Name|Description|
|----|-----------|
|`radio-dropdown:change`| Emitted when the chosen value changes. `{ detail: { value: "item-1" } }` |

### Rationale

Most barebone dropdown implementations come with a simple open/close logic, and encourage treating their children like links, like in a menu.

Sometimes, though, a dropdown acts like a toggle switch to circle between several states, like in [the Dark Mode example](../theming/dark-mode). In that case, it acts like a radio list and you want the UI to reflect this.

### Implementation

The controller expects one configuration value to be set, `data-radio-dropdown-item-selector` which is used to access the menu items. Furthermore it expects these menu items to have a `checked` attribute, like a checkbox, though you will maybe want to tweak this (see below).

It's triggered by an `updateSelection` action that reaches for the selected value and compares it to the list of items. It then sets `checked` on the respective item and updates the dropdown's `labelTarget` to reflect this.

Finally, it emits a `radio-dropdown:change` event to be picked up by other controllers or an arbitrary JavaScript event listener.

### Points to Tweak

The `updateSelection` implementation expects a certain structure of the incoming event, where the `item` coming in is stored in `event.detail` and has a `value` property. Chances are, you need to tweak this to your use case. You need to make sure that the event passed to `updateSelection` has _some_ way of accessing the selected value.

Furthermore, it expects the items to have a `checked` attribute, but you can of course use any boolean attribute instead.
