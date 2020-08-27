---
title: Home
nav_order: 1
---

# Better StimulusJS

## An Opinionated Collection of [StimulusJS](https://stimulusjs.org/) Best Practices 

[StimulusJS](https://stimulusjs.org/), the _modest JavaScript framework_ by [Basecamp](https://www.basecamp.com) is gaining widespread traction. It powers Basecamp and [HEY](https://www.hey.com), among others, and is a natural choice for Rails developers. That said, it fits any codebase that embraces server-side generated HTML and lightweight JS sprinkles.

Unfortunately, the official docs lack clear guidelines and best practice examples. Thus, this guide tries to present advice for newcomers and intermediate Stimulus programmers.

Covered topics include:

- [Architecture](./architecture.md)
  - [Application Controller](./architecture/application-controller.md)
  - [Configurable Controllers](./architecture/configurable-controllers.md)
  - [Mixins](./architecture/mixins.md)
  - [Namespaced Attributes](./architecture/namespaced-attributes.md)
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


### Who made this?
This site is maintained by [Julian Rubisch](https://github.com/julianrubisch), [Stimulus Reflex](https://docs.stimulusreflex.com) core team member and senior Rails developer. A range of [enthusiast volunteers](./contributors.md) helps keeping articles up to date and quality-assured. 

### Other Useful Resources
BetterStimulus is accompanied by

- [Stimulus Toolbox](https://stimulustoolbox.com/) - a searchable, curated repository of useful Stimulus controllers, articles etc. (by @hopsoft)

### Disagree or have comments?
Take a look at [https://github.com/julianrubisch/better-stimulus](https://github.com/julianrubisch/better-stimulus) for ways to contribute and/or discuss content.
