# Avoid generic link text

## Rule Details

Avoid setting generic link text like, "Click here", "Read more", and "Learn more" which do not make sense when read out of context.

Screen reader users often tab through links on a page to quickly find content without needing to listen to the full page. When link text is too generic, it becomes difficult to quickly identify the destination of the link. While it is possible to provide a more specific link text by setting the `aria-label`, this results in divergence between the label and the text and is not an ideal, future-proof solution.

Additionally, generic link text can also problematic for heavy zoom users where the link context is out of view.

Ensure that your link text is descriptive and the purpose of the link is clear even when read out of context of surrounding text. 
Learn more about how to write descriptive link text at [Access Guide: Write descriptive link text](https://www.accessguide.io/guide/descriptive-link-text)

### Use of ARIA attributes

It is acceptable to use `aria-label` or `aria-labelledby` to provide a more descriptive text in some cases. As note above, this is not the preferred solution and one should strive to make the visible text to be as descriptive as the design allows.

If you _must_ use this technique, you need to ensure that the accessible name completely contains the visible text. Otherwise, this is a failure of [SC 2.5.3: Label in Name](https://www.w3.org/WAI/WCAG21/Understanding/label-in-name.html).

This is not acceptable:
```
<a href="..." aria-label="GitHub announces something">Read more</a>
```

This is acceptable:
```
<a href="..." aria-label="Read more about the new accesibility feature">Read more</a>
```

This linter will raise a flag when it is able to detect that a generic link has an accessible name that doesn't contain the visible text. Due to the restrictions of static code analysis, this may not catch all violations so it is important to supplement this check with other techniques like browser tests. For instance, ERB lint will not be able to evaluate the accessible name set by `aria-labelledby` or when a variable is set to `aria-label` since this requires runtime evaluation.

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

```erb
<!-- also bad -->
<a href="github.com/about" aria-label="Why dogs are awesome">Read more</a>
```

### **Correct** code for this rule  👍

```erb
<a href="github.com/about">Learn more about GitHub</a>
```

```erb
<a href="github.com/new">Create a new repository</a>
```

```erb
<!-- not ideal but won't be flagged -->
<a aria-label="Learn more about GitHub" href="github.com/about">Learn more</a>
```
