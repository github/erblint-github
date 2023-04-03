# frozen_string_literal: true

require "test_helper"

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

  def test_does_not_raise_when_ignore_comment_with_correct_count_and_config_enabled
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoRedundantImageAltCounter 1 %>
      <img alt='image of an octopus'></img>
    ERB

    @linter.config.counter_enabled = true
    @linter.run(processed_source)
    assert_empty @linter.offenses
  end
end
