---
tags:
  - additional syntax
---

You can write flowcharts in Hibiol. Here is an example:

    Define "step",       as: "step"
    Define "decision?",  as: "Decision"
    Define "yes_step",   as: "yes_step"
    Define "no_step",    as: "no_step"
    Define "maybe_step", as: "maybe_step"

    Start with: step

    step then: another_step

    If decision? yes: yes_step
    If decision? no: no_step
    If decision? maybe: maybe_step

And this is the output:

```flowchart
    Define "step",       as: "step"
    Define "decision?",  as: "Decision"
    Define "yes_step",   as: "yes_step"
    Define "no_step",    as: "no_step"
    Define "maybe_step", as: "maybe_step"

    Start with: step

    step then: decision?

    If decision? yes: yes_step
    If decision? no: no_step
    If decision? maybe: maybe_step
```