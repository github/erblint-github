# Navigation Has Label

## Rule Details

This rule enforces that a navigation landmark (a `<nav>` or a `role="navigation"`) has an accessible name. This rule is helpful to enforce for sites (like GitHub) where multiple navigation is common.

The navigation landmark element should have an `aria-label` attribute, or `aria-labelledby` to distinguish it from other elements.

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
<nav aria-labelledby="title_id"t>
  <h1 id="title_id">This is a text</h1>
</nav>
```
