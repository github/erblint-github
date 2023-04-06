# aria-label is well formatted

## Rule Details

`[aria-label]` content should be formatted in the same way you would visual text. Please use sentence case.

Do not kebab case the words like you would an HTML ID. An `aria-label` is different from `aria-labelledby`.
An `aria-label` is not an ID, and should be formatted as human-friendly text.

## Config

If you determine that there are valid scenarios for `aria-label` to start with lowercase, you may exempt it in your `.erb-lint.yml` config like so:

```yml
  GitHub::Accessibility::AriaLabelIsWellFormatted:
    enabled: true
    exceptions:
      - allowed for some reason
      - also allowed for some reason
```

## Examples

### **Incorrect** code for this rule 👎

```erb
<button aria-label="close">
```

```erb
<button aria-label="submit">
```

```erb
<button aria-label="button-1">
```

### **Correct** code for this rule  👍

```erb
<button aria-label="Submit">
````

```erb
<button aria-label="Close">
````
