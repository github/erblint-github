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
  GitHub::Accessibility::AvoidGenericLinkTextCounter:
    enabled: true
  GitHub::Accessibility::DisabledAttributeCounter:
    enabled: true
  GitHub::Accessibility::IframeHasTitle:
    enabled: true
  GitHub::Accessibility::ImageHasAlt:
    enabled: true
  GitHub::Accessibility::LandmarkHasLabelCounter:
    enabled: true
  GitHub::Accessibility::LinkHasHrefCounter:
    enabled: true
  GitHub::Accessibility::NestedInteractiveElementsCounter:
    enabled: true
  GitHub::Accessibility::NoAriaLabelMisuseCounter:
    enabled: true
  GitHub::Accessibility::NoPositiveTabIndex:
    enabled: true
  GitHub::Accessibility::NoRedundantImageAlt:
    enabled: true
  GitHub::Accessibility::NoTitleAttributeCounter:
    enabled: true
  GitHub::Accessibility::SvgHasAccessibleTextCounter:
    enabled: true
```

## Rules

- [GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled](./docs/rules/accessibility/avoid-both-disabled-and-aria-disabled.md)
- [GitHub::Accessibility::AvoidGenericLinkTextCounter](./docs/rules/accessibility/avoid-generic-link-text-counter.md)
- [GitHub::Accessibility::DisabledAttributeCounter](./docs/rules/accessibility/disabled-attribute-counter.md)
- [GitHub::Accessibility::IframeHasTitle](./docs/rules/accessibility/iframe-has-title.md)
- [GitHub::Accessibility::LandmarkHasLabelCounter](./docs/rules/accessibility/landmark-has-label-counter.md)
- [GitHub::Accessibility::ImageHasAlt](./docs/rules/accessibility/image-has-alt.md)
- [GitHub::Accessibility::LinkHasHrefCounter](./docs/rules/accessibility/link-has-href-counter.md)
- [GitHub::Accessibility::NestedInteractiveElementsCounter](./docs/rules/accessibility/nested-interactive-elements-counter.md)
- [GitHub::Accessibility::NoAriaLabelMisuseCounter](./docs/rules/accessibility/no-aria-label-misuse-counter.md)
- [GitHub::Accessibility::NoPositiveTabIndex](./docs/rules/accessibility/no-positive-tab-index.md)
- [GitHub::Accessibility::NoRedundantImageAlt](./docs/rules/accessibility/no-redundant-image-alt.md)
- [GitHub::Accessibility::NoTitleAttributeCounter](./docs/rules/accessibility/no-title-attribute-counter.md)
- [GitHub::Accessibility::SvgHasAccessibleTextCounter](./docs/rules/accessibility/svg-has-accessible-text-counter.md)

## Disabling a rule (experimental)

_This is an experimental feature which should ideally be upstreamed to erblint_

`erblint` does not natively support rule disables. At GitHub, we've implemented these rules in a way to allow rules to be disabled at an offense-level via counters or disabled at a file-level because often times, we want to enable a rule but aren't able to address all offenses at once. We achieve this in one of two ways.

Rules that are marked as `Counter` can be disabled by adding a comment with the offense count that matches the number of offenses within the file like:

```.html.erb
<%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 1 %>
```

In this comment example, when a new `LinkHasHrefCounter` offense has been added, the counter will need to be bumped up to 2. More recent rules use a `Counter` format.

If you are enabling a rule for the first time and your codebase has a lot of offenses, you can use the `-a` command to automatically add these counter comments in the appropriate places.

```
bundle exec erblint app/views app/components -a
```

Rules that are not marked as `Counter` like `NoRedundantImageAlt` are considered to be legacy format. We are in the process of migrating these to counters. These rules can still be disabled at the file-level by adding this comment at the top of the file:

```.html.erb
<%# erblint:disable GitHub::Accessibility::NoRedundantImageAlt %>
```

However, unlike a counter, any subsequent offenses introduced to the file will not raise. 

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
