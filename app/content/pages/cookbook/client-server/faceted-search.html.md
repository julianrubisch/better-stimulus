---
layout: cookbook
title: Faceted Search
category: client-server
preview_text: 
stackblitz_url: https://stackblitz.com/edit/better-stimulus-faceted-search?file=index.html,controllers%2Ffaceted_search_controller.js&embed=1
code: |
  import { Controller } from '@hotwired/stimulus';

  // Connects to data-controller="faceted-search"
  export default class extends Controller {
    static targets = ["frame", "form"];
  
    connect() {
      // optionally use an external debounce the perform method
      // this.perform = debounce(this.#perform.bind(this), 200);
    }
  
    #perform() {
      // this will wrap any inputs and convert them to a query string
      // see https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams/URLSearchParams#parameters
      this.searchParams = new URLSearchParams(
        new FormData(this.formTarget),
      ).toString();
  
      this.frameTarget.src = `${this.formTarget.action}?${this.searchParams.toString()}`;
    }
  }
author: julianrubisch
new: true
auth: true
---

### Rationale

One of the most common requirements for any web application is that of (faceted) search. A simple implementation can be done using Turbo Frames and a straightforward small Stimulus controller wrapping a HTML form element.

### Implementation

This controller only needs two targets to work:

- a `formTarget` wrapping the form element containing the search fields, whose `action` is pointing towards an endpoint responding with a matching `<turbo-frame>`. In the example above, these are represented by a text input and a dropdown containing checkboxes.
- a `frameTarget` pointing to said Turbo Frame, whose `src` attribute to update whenever the form's parameters change.

The form inputs contain a `data-action="perform#faceted-search"`. This will convert all the form fields into an [`URLSearchParams`](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams) object via the [`FormData` constructor](https://developer.mozilla.org/en-US/docs/Web/API/FormData/FormData).

Finally, the `frameTarget`'s `src` attribute is updated to reflect the new search parameters. Conveniently, this triggers a **fetch** call and rerenders the frame automatically.

### Points to Tweak

Probably you want to debounce the `perform` action so not every single keystroke triggers a new HTTP request.
