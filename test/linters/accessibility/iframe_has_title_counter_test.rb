# frozen_string_literal: true

require "test_helper"

class IframeHasTitleCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::IframeHasTitleCounter
  end

  def test_warns_if_iframe_has_no_title
    @file = "<iframe alt='image of an octopus'></iframe>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_iframe_has_aria_hidden_to_true
    @file = "<iframe aria-hidden='true'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_iframe_has_title_set_to_string
    @file = "<iframe title='Video tutorial of GitHub Actions'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_raise_when_ignore_comment_with_correct_count
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::IframeHasTitleCounter 1 %>
      <iframe></iframe>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::IframeHasTitleCounter 1 %>
      <iframe></iframe>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <iframe></iframe>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::IframeHasTitleCounter 1 %>
      <iframe></iframe>
    ERB
    assert_equal expected_content, corrected_content
  end
end
