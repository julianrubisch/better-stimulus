---
layout: cookbook
title: Auto Sort
category: dom-manipulation
preview_text: 
stackblitz_url: https://stackblitz.com/edit/better-stimulus-auto-sort?file=index.html,controllers%2Fsort_controller.js&embed=1
code: |
  import { Controller } from '@hotwired/stimulus';
  
  export default class extends Controller {
    static values = {
      attributeName: String,
      attributeType: { type: String, default: 'number' },
    };
  
    connect() {
      this.observer = new MutationObserver(this.#sortChildren.bind(this));
      this.observer.observe(this.element, { childList: true, subtree: true });
    }
  
    disconnect() {
      this.observer.disconnect();
    }
  
    #sortChildren(_mutationList, observer) {
      observer.disconnect();
      const { children } = this;
  
      this.element.innerHTML = '';
  
      children
        .sort((a, b) => {
          switch (this.attributeTypeValue) {
            case 'string': {
              return a.dataset[this.attributeNameValue].localeCompare(
                b.dataset[this.attributeNameValue]
              );
            }
            case 'number':
            default:
              return (
                Number(a.dataset[this.attributeNameValue]) -
                Number(b.dataset[this.attributeNameValue])
              );
          }
        })
        .forEach((child) => {
          this.element.append(child);
        });
  
      observer.observe(this.element, { childList: true, subtree: true });
    }
  
    get children() {
      return Array.from(this.element.children);
    }
  }
author: julianrubisch
new: true
cache: true
---

### Configuration

|Attribute|Default|Description|Required|
|---------|-------|-----------|--------|
|`data-sort-attribute-name-value`| - | Name of the data attribute on each child element to use for sorting | yes |
|`data-sort-attribute-type-value`| `'number'` | Data type of the data attribute to use for sorting | no |



### Rationale
Suppose you have a stream of DOM elements coming in asynchronously via Websockets, for example using [Turbo Streams](https://turbo.hotwired.dev/handbook/streams).

By the very nature of Websockets, these may come in unordered. Or, maybe you want to apply a different ordering thanby creation time. In both cases, you can employ a Stimulus controller to do the sorting for you. This is done by binding a `MutationObserver` to an element and have it watch changes to the element's children. Whenever a child is added or removed, they are re-sorted using a configurable data attribute.

In the chat example above, the first case is exaggerated by a long delay between messages and made more visible using animations (which are of course optional).

In the second example, we assume that cards containing student names are coming in unordered, and we want to sort them alphabetically by their name.
