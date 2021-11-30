# No aria label misuse

## Rule Details

This rule aims to minimize misuse of the `aria-label` and `aria-labelledby` attributes because the usage of these attributes is only guaranteed on interactive elements and a subset of ARIA roles. W3C provides [a list of ARIA roles which cannot be named](https://w3c.github.io/aria/#namefromprohibited) which is used as a basis for this linter.

There are conflicting resources on what elements should support these naming attributes. For now, this rule will operate under a relatively simple heuristic aimed to minimize false positives, but has room for future improvements.

Learn more at [W3C Name Calcluation](https://w3c.github.io/aria/#namecalculation).

Also check out the following resources:
- [w3c/aria Consider prohibiting author naming certain roles #833](https://github.com/w3c/aria/issues/833)
- [Not so short note on aria-label usage - Big Table Edition](https://html5accessibility.com/stuff/2020/11/07/not-so-short-note-on-aria-label-usage-big-table-edition/)

👎 Examples of **incorrect** code for this rule:

```erb
<span aria-label="This does something">Hello</span>
```

```erb
<div aria-labelledby="heading1">Goodbye</div>
```

```erb
<h1 aria-label="This will override the content">Page title</h1>
```

👍 Examples of **correct** code for this rule:

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
<div role="dialog" aria-labelledby="dialogHeading"></div>
```
