# Counter migration guide

[ERBLint v0.4.0](https://github.com/Shopify/erb-lint/releases/tag/v0.4.0) introduces support for inline lint rule disables.

Since an inline disable feature is now natively available, it is time to move away from the in-house (hacky) counter system we've used internally over the years and in this library. 🎉

Our latest `erblint-github` release removes the `-Counter` prefix from all of the lint rules. Please update your `.erb-lint.yml` accordingly.

If your configuration looks something like:

```yaml
---
linters:
  GitHub::Accessibility::AvoidBothDisabledAndAriaCounter:
    enabled: true
  GitHub::Accessibility::AvoidGenericLinkText:
    enabled: true
  GitHub::Accessibility::DisabledAttributeCounter:
    enabled: true
```

It should become the following, with `-Counter` removed to make sure the rules run correctly.

```yaml
---
linters:
  GitHub::Accessibility::AvoidBothDisabledAndAria:
    enabled: true
  GitHub::Accessibility::AvoidGenericLinkText:
    enabled: true
  GitHub::Accessibility::DisabledAttribute:
    enabled: true
```

## Easing migration

In order to ease migration for codebases where counter comments are in place (especially large codebases), we will continue to support counters for existing lint rules for a few releases until we deprecate it completely. This should allow you to migrate rules one-by-one, rather than all at once.

With this release, the counter system will now be toggled off by default, so please explicitly enable them in your `.erb-lint.yml` config if you would like to enable counters.

```yaml
---
linters:
  GitHub::Accessibility::AvoidBothDisabledAndAria:
    enabled: true
    counter_enabled: true
  GitHub::Accessibility::AvoidGenericLinkText:
    enabled: true
    counter_enabled: true
```

With this `counter_enabled: true` config, your counter comments like `<%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaCounter 1` should work as it did before.

However, we will drop support for the counter system within the next few releases so please take time to migrate your counter comments to native inline disable comments. Any new rules added to this library will not support the counter system.

Once your files do not have any counter comments, remove the `counter_enabled: true` from your configuration to ensure no new ones are added.

## Automate migration

Adding inline disables for large codebases can be extremely tedious. We recommend using a script to automate this process.

<!-- TODO: Add script that consumers can use -->
