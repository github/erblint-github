# No title attribute counter

## Rule Details

The `title` attribute is strongly discouraged. The only exception is on an `<iframe>` element. It is hardly useful and cannot be accessed by multiple groups of users including keyboard-only users and mobile users.

The `title` attribute is commonly seen set on links, matching the link text. This is redundant and unnecessary so it can be simply be removed.

If you are considering the`title` attribute to provide supplementary description, consider whether the text in question can be persisted in the design. Alternatively, if it's important to display supplementary text that is hidden by default, consider using an **accessible** tooltip implementation that uses the `aria-labelledby` or `aria-describedby` semantics. Even so, proceed with caution: tooltips should only be used on interactive elements like links or buttons.

### Should I use the `title` attribute to provide an accessible name for an `<svg>`?

To label a _simple_ SVG that is purely graphical, we recommend the following technique for greatest assistive technology support:

- Set `role="img"` on the SVG
- Set the first child of the SVG to a `title` element that provides the accessible name for the SVG.
- Re-inforce that the `title` is the accessible name for the SVG by associating it with an `aria-labelledby` on the SVG.

Example:

```.html
<svg role="img" aria-labelledby="titleText">
  <title id="titleText">Online</title>
  ...
</svg>
```

Alternatively, if you do not care to have the native browser tooltip that is only accessible by mouse, you can use `aria-label` to label the SVG instead of `title`.

If you are dealing with complex, interactive SVGs, please consult your accessibility team.

## Resources

- [TPGI: Using the HTML title attribute ](https://www.tpgi.com/using-the-html-title-attribute/)
- [The Trials and Tribulations of the Title Attribute](https://www.24a11y.com/2017/the-trials-and-tribulations-of-the-title-attribute/)

## Examples
### **Incorrect** code for this rule 👎

```erb
<a title="A home for all developers" href="github.com">GitHub</a>
```

```erb
<a href="/" title="github.com">GitHub</a>
```

### **Correct** code for this rule  👍

```erb
<a href="github.com">GitHub</a>
```

**For [Primer ViewComponent](https://primer.style/view-components/) consumers only**:

```erb
<%= render(Primer::LinkComponent.new(href: "github.com", id: "link-with-tooltip")) do |c| %>
  <% c.tooltip(text: "A home for all developers") %>
  GitHub
<% end %>
```
