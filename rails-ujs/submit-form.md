---
title: Submit a Form Programmatically
parent: With rails-ujs
---

# Submit a Form Programmatically

```html
<div controller="remote-form">
  <%= form_with(model: @article, html: { data: { action: "ajax:success->remote-form#onPostSuccess" } }) do |f| %>
    <%= select_tag "author", options_from_collection_for_select(@people, "id", "name"),
                   data: { action: "change->remote-form#update" } %>
  <% end %>
</div>
```

Won't Work
{: .label .label-red }

```js
import { Controller } from "stimulus";

export default class extends Controller {
  onPostSuccess(event) {
    console.log("success!");
  }

  update() {
    this.element.submit();
  }
}
```
{: .border-red}

Works
{: .label .label-green}

```js
import Rails from "@rails/ujs";
import { Controller } from "stimulus";

export default class extends Controller {
  onPostSuccess(event) {
    console.log("success!");
  }

  update() {
    Rails.fire(this.element, 'submit');
  }
}
```
{: .border-green}

### Explanation
Rails-ujs intercepts form submit events that have a `data-remote="true"` attribute on the form element, but in the case of the `HTMLFormElement.submit()` method called, [no event is even fired](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit).

### Reference
- [Rails UJS](https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/start.coffee#L58)
- [HTMLFormElement.submit](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit)
- [Rails UJS Wiki](https://github.com/rails/jquery-ujs/wiki/How-to-trigger-a-form-submit-from-code)
