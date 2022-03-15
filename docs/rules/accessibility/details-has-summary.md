# Details has summary

## Rule Details
`<details>` should have a `<summary>` element hinting to the user what they'll be expanding by interfacing with the element. `<summary>` elements are helpful for screen reader users navigating the website. They are also a good UI pattern since a user agent adds their own `<summary>` if a developer omitted it with no context on what UI the details element will expand.

### 👎 Examples of **incorrect** code for this rule:

```erb
<details>
  I don't have a summary tag!
</details>
```

```erb
<details>
  <div><summary>Expand me!</summary></div>
  I have a invalid summary tag! The summary tag needs to be a direct child of the details tag.
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
