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
  GitHub::Accessibility::NoAriaLabelMisuse:
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
- [GitHub::Accessibility::IframeHasTitle](./docs/rules/accessibility/iframe-has-title.md)
- [GitHub::Accessibility::ImageHasAlt](./docs/rules/accessibility/image-has-alt.md)
- [GitHub::Accessibility::NoAriaLabelMisuse](./docs/rules/accessibility/no-aria-label-misuse.md)
- [GitHub::Accessibility::NoPositiveTabIndex](./docs/rules/accessibility/no-positive-tab-index.md)
- [GitHub::Accessibility::NoRedundantImageAlt](./docs/rules/accessibility/no-redundant-image-alt.md)
- [GitHub::Accessibility::NoTitleAttributeCounter](./docs/rules/accessibility/no-title-attribute-counter.md)

## Testing

```
bundle install
bundle exec rake
```
