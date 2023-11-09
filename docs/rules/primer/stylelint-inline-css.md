# Run stylelint on inline CSS

## Rule Details

This rule checks that inline CSS is valid and respects Primer's [stylelint config](https://github.com/primer/stylelint-config).

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<div style="color: black"></div>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<div style="color: var(--fgColor-default)"></div>
```
