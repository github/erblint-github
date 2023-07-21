# No visually hidden interactive elements

## Rule Details

This rule guards against visually hiding interactive elements. If a sighted keyboard user navigates to an interactive element that is visually hidden they might become confused and assume that keyboard focus has been lost.

Note: we are not guarding against visually hidden `input` elements at this time. Some visually hidden inputs might cause a false positive (e.g. some file inputs).

### Why do we visually hide content?

Visually hiding content can be useful when you want to provide information specifically to screen reader users or other assistive technology users while keeping content hidden from sighted users.

Applying the following css will visually hide content while still making it accessible to screen reader users.

```css
clip-path: inset(50%);
height: 1px;
overflow: hidden;
position: absolute;
white-space: nowrap;
width: 1px;
```

👎 Examples of **incorrect** code for this rule:

```jsx
<h2 className="sr-only">Welcome to GitHub</h2>
```

👍 Examples of **correct** code for this rule:

```jsx
<h2 className="sr-only">Welcome to GitHub</h2>
```

## Version
