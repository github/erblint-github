# frozen_string_literal: true

require "test_helper"
require "erblint-github/linters/github/accessibility/no_redundant_image_alt"

class NoRedundantImageAltTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoRedundantImageAlt
  end

  def test_warns_if_alt_contains_image
    @file = "<img alt='image of an octopus'></img>"
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

  def test_does_not_warn_if_linter_is_disabled_in_file
    @file = <<~HTML
      <%# erblint:disable GitHub::Accessibility::NoRedundantImageAlt %>
      <img alt='image of an octopus'></img>
    HTML

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end
end
