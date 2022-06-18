# erblint-github
Template style checking for GitHub's Ruby projects

## Setup

1. Update your `Gemfile` and run `bundle install`

``` ruby
gem "erb_lint", require: false
gem "erblint-github"
```

2. Require the linters within the `.erb-linters` folder. This could be done by adding a file `.erb-linters/erblint-github.rb` with the following line.

```ruby
require "erblint-github/linters"
```

3. Update the `erb-lint.yml` to configure the rule.

### .erb-lint.yml

```yaml 
---
linters:
  GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled:
    enabled: true
  GitHub::Accessibility::IframeHasTitle:
    enabled: true
  GitHub::Accessibility::ImageHasAlt:
    enabled: true
  GitHub::Accessibility::NoAriaLabelMisuseCounter:
    enabled: true
  GitHub::Accessibility::NoPositiveTabIndex:
    enabled: true
  GitHub::Accessibility::NoRedundantImageAlt:
    enabled: true
  GitHub::Accessibility::NoTitleAttributeCounter:
    enabled: true
```

## Rules

- [GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled](./docs/rules/accessibility/avoid-both-disabled-and-aria-disabled.md)
- [GitHub::Accessibility::AvoidGenericLinkTextCounter](./docs/rules/accessibility/avoid-generic-link-text-counter.md)
- [GitHub::Accessibility::IframeHasTitle](./docs/rules/accessibility/iframe-has-title.md)
- [GitHub::Accessibility::ImageHasAlt](./docs/rules/accessibility/image-has-alt.md)
- [GitHub::Accessibility::NoAriaLabelMisuseCounter](./docs/rules/accessibility/no-aria-label-misuse-counter.md)
- [GitHub::Accessibility::NoPositiveTabIndex](./docs/rules/accessibility/no-positive-tab-index.md)
- [GitHub::Accessibility::NoRedundantImageAlt](./docs/rules/accessibility/no-redundant-image-alt.md)
- [GitHub::Accessibility::NoTitleAttributeCounter](./docs/rules/accessibility/no-title-attribute-counter.md)

## Testing

```
bundle install
bundle exec rake
```

## Recommended extension

If you use VS Code, we highly encourage [ERB Linter extension](https://marketplace.visualstudio.com/items?itemName=manuelpuyol.erb-linter) to see immediate feedback in your editor.

## Note

This repo contains several accessibility-related linting rules to help surface accessibility issues that would otherwise go undetected until a later stage. Please note that due to the limitations of static code analysis,
these ERB accessibility checks are NOT enough for ensuring the accessibility of your app. This shouldn't be the only tool you use to catch accessibility issues and should be supplemented with other tools that can check the runtime browser DOM output, as well as processes like accessibility design reviews, manual audits, user testing, etc.