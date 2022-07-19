# Link Has Href

## Rule Details

Links should go somewhere, you probably want to use a `<button>` instead.

## Resources

- [`<a>`: The Anchor element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a)
- [Primer: Links](https://primer.style/design/accessibility/links)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<a>Go to GitHub</a>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<a href='https://github.com/'>Go to GitHub</a>
```