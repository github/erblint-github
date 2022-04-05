# Image Has Alt

## Rule Details

`<img>` should have an alt prop with meaningful text or an empty string for decorative images.

## Resources

- [W3C WAI Images Tutorial](https://www.w3.org/WAI/tutorials/images/)
- [Primer: Alternative text for images](https://primer.style/design/accessibility/alternative-text-for-images)

## Examples
### 👎 Examples of **incorrect** code for this rule:

```erb
<img src="logo.png">
```

### 👍 Examples of **correct** code for this rule:

```erb
<!-- good -->
<img alt="" src="logo.png" >
```

```erb
<!-- also good -->
<a href='https://github.com/'><img alt="GitHub homepage" src="logo.png" ></a>
```
