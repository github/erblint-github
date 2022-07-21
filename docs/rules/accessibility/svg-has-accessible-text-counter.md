# SVG has accessible text counter

## Rule Details

`<svg>` must have accessible text. Set `aria-label`, or `aria-labelledby`, or nest a `<title>` element.
However, if the `<svg>` is purely decorative, hide it with `aria-hidden='true'.

## Resources

- [Accessible SVGs](https://css-tricks.com/accessible-svgs/)

## Examples
### **Incorrect** code for this rule 👎

```erb
<!-- incorrect -->
<svg height='100' width='100'>
  <circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/>
</svg>
```

### **Correct** code for this rule  👍

```erb
<!-- correct -->
<svg aria-label='A circle' height='100' width='100'>
  <circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/>
</svg>

<!-- correct -->
<svg aria-labelledby='test_id' height='100' width='100'>
  <circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/>
</svg>

<!-- correct -->
<svg height='100' width='100'>
  <title>A circle</title>
  <circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/>
</svg>
```
