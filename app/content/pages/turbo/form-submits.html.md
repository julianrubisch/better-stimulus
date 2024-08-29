---
layout: article
title: Form Submits
category: turbo
preview_text: 
author: julianrubisch
cache: true
new: true
---

### Pain Point

- You want to submit a form in response to any arbitrary JavaScript event.

```erb
<%= form_with(model: @article, data: {controller: "form"})
  do |f| %>
    <%= select_tag "author",
                   options_from_collection_for_select(@people, "id", "name"),
                   data: {action: "change->form#update"} %>
<% end %>
```

```js
// app/javascript/controllers/form_controller.js
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  update(event) {
    event.preventDefault()
    
    this.element.requestSubmit()
  }
}
{: .border .border-green}
```

In the example above we don't want to force the user to use the form's submit button, but rather submit it when the `<select>`'s value changes. We can do that by connecting the `change` event to the `update` action in our Stimulus controller, and call `requestSubmit()`.

---

- You want to intercept a regular form submission to execute additional client-side logic.

```erb
<%= form_with(model: @article, data: {controller: "form", action: "submit->form#intercept"})
  do |f| %>
<% end %>
```

```js
// app/javascript/controllers/form_controller.js
import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'

export default class extends Controller {
  intercept(event) {
    event.preventDefault()
    
    const data = new FormData(this.element)

    // do something here, e.g. validate or append new items to the form's data

    patch(this.element.action, { body: data, responseKind: 'turbo-stream' })
  }
}
{: .border .border-green}
```

In this case we intercept the `submit` event that is triggered when the form is submitted. We reuse the data that has been entered into the form with `FormData` and, for example, append some more items the the data or perform client-side validation.

