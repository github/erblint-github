# No aria label misuse

## Rule Details

This rule aims to discourage common misuse of the `aria-label` and `aria-labelledby` attribute. `aria-label` and `aria-labelledby` support is only guaranteed on interactive elements like `button` or `a`, or on static elements like `div` and `span` with a permitted `role`. This rule will allow `aria-label` and `aria-labelledby` usage on `div` and `span` elements if it set to a role other than the ones listed in [WSC: a list of ARIA roles which cannot be named](https://w3c.github.io/aria/#namefromprohibited). This rule will never permit usage of `aria-label` and `aria-labelledby` on `h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `strong`, `i`, `p`, `b`, or `code`.

### "Help! I'm trying to set a tooltip on a static element and this rule flagged it!"

Please do not use tooltips on static elements. It is a highly discouraged, inaccessible pattern for the following reasons:

- Static elements are not tab-focusable so keyboard-only users will not be able to access the tooltip at all. (Note: setting `tabindex="0"` to force a generic element to be focusable is not a solution.)
- It's likely that tooltip is inappropriate for your usecase to begin with. Tooltips are not accessible at all on mobile devices so if you're trying to convey critical information, use something else. Additionally, implementing tooltip as `aria-label` is rarely appropriate and has potential to cause accessibility issues for screen reader users.

If you've determined the tooltip content is not critical, simply remove it. If you determine the tooltip content is important to keep, we encourage you to reach out to a design or accessibility team who can assist in finding an alternate, non-tooltip pattern.

### Resources

- [w3c/aria Consider prohibiting author naming certain roles #833](https://github.com/w3c/aria/issues/833)
- [Not so short note on aria-label usage - Big Table Edition](https://html5accessibility.com/stuff/2020/11/07/not-so-short-note-on-aria-label-usage-big-table-edition/)
- [Your tooltips are bogus](https://heydonworks.com/article/your-tooltips-are-bogus/)

### Disclaimer

There are conflicting resources and opinions on what elements should support these naming attributes. For now, this rule will operate under a relatively simple heuristic aimed to minimize false positives. This may have room for future improvements. Learn more at [W3C Name Calcluation](https://w3c.github.io/aria/#namecalculation).

### 👎 Examples of **incorrect** code for this rule:

```erb
<span class="tooltipped" aria-label="This is a tooltip">I am some text.</span>
```

```erb
<span aria-label="This is some content that will completely override the button content">Please be careful of the following.</span>
```

```erb
<div aria-labelledby="heading1">Goodbye</div>
```

```erb
<h1 aria-label="This will override the page title completely">Page title</h1>
```

### 👍 Examples of **correct** code for this rule:

```erb
<button aria-label="Close">
  <svg src="closeIcon"></svg>
</button>
```

```erb
<button aria-label="Bold" aria-describedby="tooltip1">
  <svg src="boldIcon"></svg>
</button>
<p id="tooltip1" class="tooltip">Add bold text or turn selection into bold text</p>
```

```erb
<span>Hello</span>
```

```erb
<div>Goodbye</div>
```

```erb
<h1>Page title</h1>
```

```erb
<div role="dialog" aria-labelledby="dialogHeading">
  <h1 id="dialogHeading">Heading</h1>
</div>
```
