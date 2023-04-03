# No positive tab index

## Rule Details

Do not positive tabindex as it is error prone and can severely disrupt navigation experience for keyboard users.

Learn more at:

- [A11yProject: Use the tabindex attribute](https://www.a11yproject.com/posts/how-to-use-the-tabindex-attribute/)
- [Deque: Avoid using Tabindex with positive numbers](https://dequeuniversity.com/tips/tabindex-positive-numbers)

## Examples
### **Incorrect** code for this rule 👎

```erb
<button tabindex="3"></button>
<button tabindex="1"></button>
```

### **Correct** code for this rule  👍

```erb
<!-- good -->
<button tabindex="0"></button>
```

```erb
<!-- also good -->
<button tabindex="-1"></button>
```
