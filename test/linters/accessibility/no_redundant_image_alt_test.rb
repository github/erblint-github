# frozen_string_literal: true

require "test_helper"

class NoRedundantImageAltCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoRedundantImageAltCounter
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

  def test_does_not_raise_when_ignore_comment_with_correct_count
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoRedundantImageAltCounter 1 %>
      <img alt='image of an octopus'></img>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoRedundantImageAltCounter 1 %>
      <img alt='image of an octopus'></img>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <img alt='image of an octopus'></img>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoRedundantImageAltCounter 1 %>
      <img alt='image of an octopus'></img>
    ERB
    assert_equal expected_content, corrected_content
  end
end
