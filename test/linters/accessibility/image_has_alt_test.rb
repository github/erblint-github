# frozen_string_literal: true

require "test_helper"

class ImageHasAltTest < LinterTestCase
  include SharedLinterTests

  def linter_class
    ERBLint::Linters::GitHub::Accessibility::ImageHasAlt
  end

  def example_invalid_case
    <<~HTML
      <img></img>
    HTML
  end

  def test_warns_if_image_has_no_alt_attribute
    @file = example_invalid_case
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_image_has_alt_attribute_set_to_empty_string
    @file = "<img alt=''></img>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_image_has_alt_attribute_set_to_string
    @file = "<img alt='monalisa'></img>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
