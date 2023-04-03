# No aria-hidden on focusable

## Rule Details

Elements that are focusable should never have `aria-hidden="true"` set.

`aria-hidden="true"` hides elements from assistive technologies. `aria-hidden="true"` should only be used to hide non-interactive content such as decorative elements or redundant text. If a focusable element has `aria-hidden="true"`, it can cause confusion amongst assistive technology users who may be able to reach the element but not receive information about it.

### Resources

- [Accessibility insights: aria-hidden-focus](https://accessibilityinsights.io/info-examples/web/aria-hidden-focus/)
- [Deque: aria-hidden elements do not contain focusable elements](https://dequeuniversity.com/rules/axe/html/4.4/aria-hidden-focus)
- [W3: Element with aria-hidden has no content in sequential focus navigation](https://www.w3.org/WAI/standards-guidelines/act/rules/6cfa84/proposed/)

## Examples

### **Incorrect** code for this rule 👎

```erb
<button aria-hidden="true">Submit</button>
```

```erb
<div role="menuitem" aria-hidden="true" tabindex="0"></div>
```

### **Correct** code for this rule  👍

```erb
<button>Submit</button>
```

```erb
<div role="menuitem" aria-hidden="true" tabindex="-1"></div>
```
