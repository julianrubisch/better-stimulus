---
title: Home
nav_order: 1
---

{: .important-title }
> News
>
> Check out my new Patron community, [The Hotwire Club](https://patreon.com/TheHotwireClub)

# Better StimulusJS

## An Opinionated Collection of [StimulusJS](https://stimulus.hotwired.dev/) Best Practices

[StimulusJS](https://stimulus.hotwired.dev/), the _modest JavaScript framework_ by [Basecamp](https://www.basecamp.com) is gaining widespread traction. It powers Basecamp and [HEY](https://www.hey.com), among others, and is a natural choice for Rails developers. That said, it fits any codebase that embraces server-side generated HTML and lightweight JS sprinkles.

Unfortunately, the official docs lack clear guidelines and best practice examples. Thus, this guide tries to present advice for newcomers and intermediate Stimulus programmers.

Covered topics include:

- [Architecture](./architecture.md)
  - [Application Controller](./architecture/application-controller.md)
  - [Configurable Controllers](./architecture/configurable-controllers.md)
  - [Mixins](./architecture/mixins.md)
  - [Namespaced Attributes](./architecture/namespaced-attributes.md)
- [DOM manipulation](./dom_manipulation.md)
  - [Use `<template>` to Restore DOM State](./dom_manipulation/template.md)
- [Error Handling](./error_handling.md)
  - [Global Error Handler](./error_handling/global-error-handler.md)
- [Events](./events.md)
- [Integrating Libraries](./integrating-libraries.md)
  - [Use Lifecycle Events for Setup and Teardown](./integrating-libraries/lifecycle.md)
- [Interaction](./interaction.md)
  - [Controller DOM Mapper](./interaction/controller-dom-mapper.md)
  - [Use Callbacks to Communicate Between Controllers](./interaction/callbacks.md)
- [SOLID](./solid.md)
  - [Single Responsibility Principle](./solid/single-responsibility.md)
- [With rails-ujs](./rails-ujs.md)
  - [Submit a Form Programmatically](./rails-ujs/submit-form.md)
- [With Turbo](./turbo.md)
  - [Global Teardown](./turbo/teardown.md)

### Stay Informed

Get updates when new articles are posted:

<!-- Begin Mailchimp Signup Form -->
<div id="mc_embed_signup">
<form action="https://julianrubisch.us17.list-manage.com/subscribe/post?u=31a183f5375fb6e851c5b4aaf&amp;id=782508f3d8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate p-4" target="_blank" novalidate>
    <div id="mc_embed_signup_scroll">
<div class="indicates-required"><span class="asterisk">*</span> indicates required</div>
<div class="mc-field-group d-flex flex-justify-between">
	<label for="mce-EMAIL mr-3">Email Address  <span class="asterisk">*</span>
</label>
	<input type="email" value="" name="EMAIL" class="required email" id="mce-EMAIL">
</div>
<div id="mergeRow-gdpr" class="mergeRow gdpr-mergeRow content__gdprBlock mc-field-group mt-6">
    <div class="content__gdpr">
        <label class="text-gamma">Marketing Permissions</label>
        <p>Please select all the ways you would like to hear from :</p>
        <fieldset class="mc_fieldset gdprRequired mc-field-group" name="interestgroup_field">
		<label class="checkbox subfield" for="gdpr_83570"><input type="checkbox" id="gdpr_83570" name="gdpr[83570]" value="Y" class="av-checkbox gdpr mt-3"><span class="ml-3">Email</span> </label>
        </fieldset>
        <p>You can unsubscribe at any time by clicking the link in the footer of our emails. For information about our privacy practices, please visit our website.</p>
    </div>
    <div class="content__gdprLegal">
        <p>We use Mailchimp as our marketing platform. By clicking below to subscribe, you acknowledge that your information will be transferred to Mailchimp for processing. <a href="https://mailchimp.com/legal/" target="_blank">Learn more about Mailchimp's privacy practices here.</a></p>
    </div>
</div>
	<div id="mce-responses" class="clear">
		<div class="response" id="mce-error-response" style="display:none"></div>
		<div class="response" id="mce-success-response" style="display:none"></div>
	</div>    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
    <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_31a183f5375fb6e851c5b4aaf_782508f3d8" tabindex="-1" value=""></div>
    <div class="clear"><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="btn btn-purple"></div>
    </div>
</form>
</div>

<!--End mc_embed_signup-->


### Who made this?
This site is maintained by [Julian Rubisch](https://github.com/julianrubisch), [Stimulus Reflex](https://docs.stimulusreflex.com) core team member and senior Rails developer. A range of [enthusiast volunteers](./contributors.md) helps keeping articles up to date and quality-assured.

### Disagree or have comments?
Take a look at [https://github.com/julianrubisch/better-stimulus](https://github.com/julianrubisch/better-stimulus) for ways to contribute and/or discuss content.
