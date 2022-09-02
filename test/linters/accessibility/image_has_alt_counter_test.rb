# frozen_string_literal: true

require "test_helper"

class ImageHasAltCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::ImageHasAltCounter
  end

  def test_warns_if_image_has_no_alt_attribute
    @file = "<img></img>"
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

  def test_does_not_raise_when_ignore_comment_with_correct_count
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::ImageHasAltCounter 1 %>
      <img></img>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::ImageHasAltCounter 1 %>
      <img></img>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <img></img>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::ImageHasAltCounter 1 %>
      <img></img>
    ERB
    assert_equal expected_content, corrected_content
  end
end
