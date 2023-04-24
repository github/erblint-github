# aria-label is well formatted

## Rule Details

`[aria-label]` content should be formatted in the same way you would visual text.

Keep the following practices in mind:

- Use sentence case.
- Do not kebab case the words like you would an HTML ID. An `aria-label` is different from `aria-labelledby`. An `aria-label` represents the name of a control, and has the same purpose as a visual label would for screen reader users. Therefore, it should be formatted as human-friendly text.
- Do not use line-break characters like `&#10;`. An accessible name should be concise to start with.
- Do not set the `aria-label` to a URL. Instead, use an appropriate human-friendly description.

## Resources

- [Staff only: Guidance on naming controls](https://github.com/github/accessibility-playbook/blob/main/content/link-and-button-guidance.mdx#guidance-on-naming-controls)

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

```erb
<button aria-label="Go to my&#10;website.">
```

```erb
<a href="https://github.com/shopify/erb-lint"> aria-label="github.com/shopify/erb-lint"></a>
```

### **Correct** code for this rule  👍

```erb
<button aria-label="Submit">
````

```erb
<button aria-label="Close">
````

```erb
<a href="https://github.com/shopify/erb-lint" aria-label="Shopify/erb-lint on GitHub"></a>
```
