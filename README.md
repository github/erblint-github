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
  Accessibility::ImageHasAlt:
    enabled: true
  Accessibility::NoRedundantImageAlt:
    enabled: true
```

### Rules

- [Accessibility::NoRedundantImageAlt](./docs/rules/accessibility/no-redundant-image-alt.md)
- [Accessibility::ImageHasAlt](./docs/rules/accessibility/image-has-alt.md)

## Testing

```
bundle install
bundle exec rake
```
