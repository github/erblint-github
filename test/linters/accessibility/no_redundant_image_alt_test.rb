# frozen_string_literal: true

require "test_helper"

class NoRedundantImageAltTest < LinterTestCase
  include SharedLinterTests

  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoRedundantImageAlt
  end

  def example_invalid_case
    <<~HTML
      <img alt='image of an octopus'></img>
    HTML
  end

  def test_warns_if_alt_contains_image
    @file = example_invalid_case
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_if_alt_contains_picture
    @file = "<img alt='picture of an octopus'></img>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_alt_contains_no_redundant_text
    @file = "<img alt='an octopus'></img>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
