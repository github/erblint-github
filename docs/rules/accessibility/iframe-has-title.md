# Iframe has title

## Rule Details

`<iframe>` should have a unique title attribute that identifies the content. The title will help screen reader users determine whether to explore the frame in detail. If an `<iframe>` contains no meaningful content, hide it by setting `aria-hidden="true"`.

## Examples
### 👎 Examples of **incorrect** code for this rule:

```erb
<iframe src="../welcome-video"></iframe>
```

### 👍 Examples of **correct** code for this rule:

```erb
<!-- good -->
<iframe  src="../welcome-video" title="Welcome to GitHub Video" ></iframe>
```

```erb
<!-- also good -->
<iframe aria-hidden="true">
    <!-- Meaningless JavaScript code -->
</iframe>
```
