# erblint-github

Template style checking for GitHub's Ruby projects

## Setup

1. Update your `Gemfile` and run `bundle install`

``` ruby
gem "erb_lint", require: false
gem "erblint-github"
```

2. Require the lint rules from this library. Currently, the only supported way is to add a new file in `.erb-linters/erblint-github.rb` with the line:

```ruby
require "erblint-github/linters"
```

3. Update your `erb-lint.yml` to pull in our recommended configs. This will ensure you are up-to-date with our recommendations.

```yaml
---
inherit_gem:
  erblint-github:
    - config/accessibility.yml
```

## Rules

- [GitHub::Accessibility::AriaLabelIsWellFormatted](./docs/rules/accessibility/aria-label-is-well-formatted.md)
- [GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled](./docs/rules/accessibility/avoid-both-disabled-and-aria-disabled.md)
- [GitHub::Accessibility::AvoidGenericLinkText](./docs/rules/accessibility/avoid-generic-link-text.md)
- [GitHub::Accessibility::DisabledAttribute](./docs/rules/accessibility/disabled-attribute.md)
- [GitHub::Accessibility::NavigationHasLabel](./docs/rules/accessibility/navigation-has-label.md)
- [GitHub::Accessibility::LinkHasHref](./docs/rules/accessibility/link-has-href.md)
- [GitHub::Accessibility::NestedInteractiveElements](./docs/rules/accessibility/nested-interactive-elements.md)
- [GitHub::Accessibility::IframeHasTitle](./docs/rules/accessibility/iframe-has-title.md)
- [GitHub::Accessibility::ImageHasAlt](./docs/rules/accessibility/image-has-alt.md)
- [GitHub::Accessibility::NoAriaHiddenOnFocusable](./docs/rules/accessibility/no-aria-hidden-on-focusable.md)
- [GitHub::Accessibility::NoAriaLabelMisuse](./docs/rules/accessibility/no-aria-label-misuse.md)
- [GitHub::Accessibility::NoPositiveTabIndex](./docs/rules/accessibility/no-positive-tab-index.md)
- [GitHub::Accessibility::NoRedundantImageAlt](./docs/rules/accessibility/no-redundant-image-alt.md)
- [GitHub::Accessibility::NoVisuallyHiddenInteractiveElements](./docs/rules/accessibility/no-visually-hidden-interactive-elements.md)
- [GitHub::Accessibility::NoTitleAttribute](./docs/rules/accessibility/no-title-attribute.md)
- [GitHub::Accessibility::SvgHasAccessibleText](./docs/rules/accessibility/svg-has-accessible-text.md)

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
