# Link Has Href counter

## Rule Details

An `<a>` element that has an href attribute represents a hyperlink (a hypertext anchor) labeled by its contents. Links, `<a>` elements, should go somewhere, you probably want to use a `<button>` instead.


## Resources

- [`<a>`: The Anchor element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a)
- [Primer: Links](https://primer.style/design/accessibility/links)
- [HTML Spec: The a element](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-a-element)

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
