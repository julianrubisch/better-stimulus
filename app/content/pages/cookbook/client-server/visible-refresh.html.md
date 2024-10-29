---
layout: cookbook
title: Refresh when Visible
category: client-server
preview_text: 
stackblitz_url: https://stackblitz.com/edit/better-stimulus-visible-refresh-poll?file=index.html,controllers%2Fvisible_poll_controller.js&embed=1
code: |
  import { Controller } from "@hotwired/stimulus";
  
  // Connects to data-controller="visible-refresh"
  export default class extends Controller {
    // static values = { interval: { type: Number, default: 60000 } };
  
    // connect() {
    //   this.interval = setInterval(this.appendRefresh, this.intervalValue);
    // }
  
    // disconnect() {
    //   clearInterval(this.interval);
    // }
  
    trigger() {
      this.appendRefresh();
    }
  
    appendRefresh = () => {
      if (!document.hidden) {
        // append turbo refresh template
        document.body.insertAdjacentHTML(
          "beforeend",
          '<turbo-stream action="refresh"></turbo-stream>',
        );
      }
    };
  }
author: julianrubisch
cache: true
new: true
---

### Configuration

|Attribute|Default|Description|Required|
|---------|-------|-----------|--------|
|`data-visible-refresh-interval-value`| 60000 | Poll interval (optional add-on) | no |

### Rationale
I developed this controller when I wrote my first "real" PWA and ran into an issue:

Out of the box, you can't just refresh a page if you need to update the page contents. Now this might not be a problem for the majority of apps, but at the moment you've got some real-time data streams coming in (e.g. a metrics dashboard, or from a third-party API), this becomes annoying.

The solution I came up with makes use of the [Page Visibility API](https://developer.mozilla.org/en-US/docs/Web/API/Page_Visibility_API), which provides events that indicate whether a document is hidden or not. Hidden, in this case can mean things like:

- the user switched to another browser tab,
- she minimized the window,
- the browser window is covered by another window,
- the PWA (as in our case) has been put into the background,
- etc.

So, conversely, this controller uses the [`visibilitychange`](https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilitychange_event) event to trigger a refresh when the page becomes visible again.

### Implementation

As a modern Rails take on polling, this controller uses a lambda, `appendRefresh`, to trigger a Turbo refresh. If your [Turbo refresh method](https://turbo.hotwired.dev/handbook/page_refreshes#morphing) is set to morphing, it will morph instead of replace the whole document.

So, by wiring up the `trigger` action to the `visibilitychange` event in your DOM, a refresh will happen whenever the page becomes _visible_:

```html
<section data-controller="visible-refresh"
         data-action="visibilitychange@document->visible-refresh#trigger">
```

### Bonus

Optionally (hence commented out), this controller includes a configurable `setInterval` to trigger a recurring refresh. This might be helpful if you're dealing with a dashboard being fed by external data, for example.
