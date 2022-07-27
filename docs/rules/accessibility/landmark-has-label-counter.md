# Landmark Has Label Counter

## Rule Details

Landmark elements should have an `aria-label` attribute, or `aria-labelledby` if a heading elements exists in the landmark.

## Resources

- [ARIA Landmarks Example](https://www.w3.org/WAI/ARIA/apg/example-index/landmarks/index.html)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<section>
  <h1>This is a text</h1>
</section>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<section aria-labelledby="title_id"t>
  <h1 id="title_id">This is a text</h1>
</section>
```
