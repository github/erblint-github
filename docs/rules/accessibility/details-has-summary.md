# Details has summary

## Rule Details
`<details>` should have a `<summary>` element hinting to the user what they'll be expanding by interfacing with the element. This is useful to screen reader users to navigate the website as well as a good UI pattern since omitting a `<summary>` element lets the user agent inject their own `<summary>` element that adds no context to the control.

### 👎 Examples of **incorrect** code for this rule:

```erb
<details>
  I don't have a summary tag!
</details>
```

### 👍 Examples of **correct** code for this rule:

```erb
<details>
  <summary>Expand me!</summary>
  I do have a summary tag!
</details>
````

```erb
<details>
  I do have a summary tag!
  <summary>Expand me!</summary>
</details>
````
