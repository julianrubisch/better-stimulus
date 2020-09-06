---
title: Use &lt;template&gt; to Restore DOM State
nav_order: 1
parent: DOM Manipulation
---

# Use `<template>` to Restore DOM State

#### by @julianrubisch {% avatar julianrubisch size=24 %}
{: .fs-3 }

### Rationale
In some cases, it can be necessary to reset your DOM to a known state before leaving the page. This is especially true when using Turbolinks, because it will cache the current state before navigating away and show it as a preview when doing a restoration visit.
