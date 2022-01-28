# No redundant image alt

## Rule Details

`<img>` alt prop should not contain `image` or `picture` as screen readers already announce the element as an image.

This rule does not discourage conveying the _medium_ of the image which may be considered important to help a user better understand the content.
For example, this rule will not flag terms including `screenshot`, `painting`, or `photograph`.

Learn more at [W3C WAI Images Tutorial](https://www.w3.org/WAI/tutorials/images/).

### 👎 Examples of **incorrect** code for this rule:

```erb
<img alt="picture of Mona Lisa" src="monalisa.png">
```

```erb
<!-- also bad -->
<img alt="image of a fluffy dog" src="monalisa.png">
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

```erb
<!-- also good -->
<img alt="Screenshot of the user profile Settings page, with the 'Notifications' item highlighted" src="settings_page.png">
```
