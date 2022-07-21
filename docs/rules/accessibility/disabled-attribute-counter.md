# Disabled attribute counter

## Rule Details

The attribute `disabled` is only valid on the following elements: button, input, textarea, option, select, fieldset, optgroup, task-lists.

## Resources

- [HTML attribute: `disabled`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/disabled)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<a href='https://github.com/' disabled>Go to GitHub</a>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<button disabled>Continue</button>
```
