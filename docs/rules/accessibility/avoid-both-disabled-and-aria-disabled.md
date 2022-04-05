# Avoid both disabled and aria disabled

## Rule Details

[From w3 ARIA in HTML ](https://www.w3.org/TR/html-aria/#docconformance-attr):
> authors MAY use aria-disabled=true on a button element, rather than the disabled attribute. However, authors SHOULD NOT use both the native HTML attribute and the aria-* attribute together,

HTML elements with `disabled` are ignored when a screen reader uses tab navigation. To expose the disabled element, one may use `aria-disabled` and custom js and css to mimic disabled behavior *instead*. Setting both `aria-disabled` and `disabled` is unnecessary.

This linter will raise when both `aria-disabled` and `disabled` are set on HTML elements that natively support `disabled` including `button`, `fieldset`, `input`, `optgroup`, `option`, `select`, and `textarea`.

## Examples
### 👎 Examples of **incorrect** code for this rule:

```erb
<button aria-disabled="true" disabled="true">
<input aria-disabled="true" disabled="true">
```

### 👍 Examples of **correct** code for this rule:

```erb
<button disabled="true">
````

```erb
<input disabled="true">
```

```erb
<button aria-disabled="true" class="js-disabled-button disabled-button">Update</button>
```
