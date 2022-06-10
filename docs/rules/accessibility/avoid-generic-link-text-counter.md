# Avoid generic link text

## Rule Details

Avoid setting generic link text like, "Click here", "Read more", and "Learn more" which do not make sense when read out of context. Screen reader users often tab through links on a page to quickly find content without needing to listen to the full page. When link text is too generic, it becomes difficult to quickly identify the destination of the link.

## Resources

- [Primer: Links](https://primer.style/design/accessibility/links)
- [Understanding Success Criterion 2.4.4: Link Purpose (In Context)](https://www.w3.org/WAI/WCAG21/Understanding/link-purpose-in-context.html)
- [WebAim: Links and Hypertext](https://webaim.org/techniques/hypertext/)
- [Deque: Use link text that make sense when read out of context](https://dequeuniversity.com/tips/link-text)

## Examples

### **Incorrect** code for this rule 👎

```erb
<a href="github.com/about">Learn more</a>
```

```erb
<!-- also bad -->
<a href="github.com/about">Read more</a>
```

```erb
<!-- also bad -->
<span>
  <a href="github.com/new">Click here</a> to create a new repository.
</span>
```

```erb
<!-- also bad -->
<%= link_to "Learn more", "#" %>
```

### **Correct** code for this rule  👍

```erb
<a href="github.com/about">Learn more about GitHub</a>
```

```erb
<a href="github.com/new">Create a new repository</a>
```
