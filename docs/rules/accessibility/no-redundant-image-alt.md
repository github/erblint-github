# No redundant image alt

## Rule Details

`<img>` alt prop should not contain `image` or `picture` as screen readers already announce the element as an image.

Learn more at [W3C WAI Images Tutorial](https://www.w3.org/WAI/tutorials/images/).

### 👎 Examples of **incorrect** code for this rule:

```erb
<img alt="picture of Mona Lisa" src="monalisa.png">
```

### 👍 Examples of **correct** code for this rule:

```erb
<!-- good -->
<img alt="Mona Lisa" src="monalisa.png">
```


```erb
<!-- also good -->
<img alt="The original painting of Mona Lisa hangs on the wall of Louvre museum" src="monalisa.png">
```
