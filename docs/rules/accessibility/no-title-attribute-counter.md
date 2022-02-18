# No title attribute counter

## Rule Details

The `title` attribute is strongly discouraged. The only exception is on an `<iframe>` element. It is hardly useful and cannot be accessed by multiple groups of users including keyboard-only users and mobile users.

The `title` attribute is commonly seen set on links, matching the link text. This is redundant and unnecessary so it can be simply be removed.

If you are considering `title` attribute to provide supplementary description, consider whether the text in question can be persisted in the design. Alternatively, if it's important to display supplementary text that is hidden by default, consider using an **accessible** tooltip implementation that uses the `aria-labelledby` or `aria-describedby` semantics. Even so, proceed with caution: tooltips should only be used on interactive elements like links or buttons.

### Should I use `title` attribute to provide accessible name for `<svg>`?

Use a `<title>` element instead of the `title` attribute, or an `aria-label`.

### Resources

- [TPGI: Using the HTML title attribute ](https://www.tpgi.com/using-the-html-title-attribute/)
- [The Trials and Tribulations of the Title Attribute](https://www.24a11y.com/2017/the-trials-and-tribulations-of-the-title-attribute/)

### 👎 Examples of **incorrect** code for this rule:

```erb
<a title="A home for all developers" href="github.com">GitHub</a>
```

```erb
<a href="/" title="github.com">GitHub</a>
```

### 👍 Examples of **correct** code for this rule:

```erb
<a href="github.com" aria-describedby="description">GitHub</a>
<p id="description" class="tooltip js-tooltip">A home for all developers</p>
```

```erb
<a href="github.com">GitHub</a>
```
