# No aria-hidden on focusable counter

## Rule Details

Elements that are focusable should not have `aria-hidden="true"` set.

`aria-hidden="true"` hides an element from assistive technologies, but if the element is still reachable by keyboard, it can cause confusion amongst assistie technology users who may be able to reach the element, but not have access to the element or it's information.

### Resources

- [Accessibility insights: aria-hidden-focus](https://accessibilityinsights.io/info-examples/web/aria-hidden-focus/)

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
