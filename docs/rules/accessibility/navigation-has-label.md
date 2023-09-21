# Navigation Has Label

## Rule Details

This rule enforces that a navigation landmark (a `<nav>` or a `role="navigation"`) has an accessible name. This rule is helpful for sites (like GitHub) where multiple navigation elements is common.

An accessible name ensures that one can distinguish between multiple navigation elements.

If the navigation area begins with a heading, use the heading to label the navigation element using the `aria-labelledby` attribute. If there is no heading, then you may set `aria-label`. Make sure to format the text the same way you would visual text (Related: [aria-label is well formatted](./aria-label-is-well-formatted.md)).

### Assess whether a navigation landmark should be used at all

This rule will flag all navigation landmarks that don't have an accessible name. However, in some instances, a navigation landmark may be inappropriately used. While addressing this rule, please assess whether or not the instance you're looking at _should_ be a navigation landmark, and follow-up accordingly.

### Don't include "navigation" in the name

The accessible name for a navigation landmark should NOT include "navigation" because that would add redundancy and verbosity, since screen readers will already announce the navigation landmark.

## Resources

- [ARIA Landmarks Example](https://www.w3.org/WAI/ARIA/apg/example-index/landmarks/index.html)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<nav>
  <h1>This is a text</h1>
</nav>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<nav aria-labelledby="title_id">
  <h1 id="title_id">Setings</h1>
  ...
</nav>
```

```erb
<!-- correct -->
<nav aria-label="Repos">
  ...
</nav>
```
