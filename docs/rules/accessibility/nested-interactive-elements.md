# Nested Interactive Elements

## Rule Details

Certain interactive controls such as `button`, `summary`, `input`, `select`, `textarea`, or `a` can't have interactive children. Nesting interactive elements produces invalid HTML, and assistive technologies, such as screen readers, might ignore or respond unexpectedly to such nested controls. 

## Resources

- [Deque University](https://dequeuniversity.com/rules/axe/4.2/nested-interactive)
- [Accessibility Insights](https://accessibilityinsights.io/info-examples/web/nested-interactive/)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<button>
  <a href='https://github.com/'>Go to GitHub</a>
</button>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<button>Confirm</button>
```
