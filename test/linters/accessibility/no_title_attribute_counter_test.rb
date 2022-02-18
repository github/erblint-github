# frozen_string_literal: true

require "test_helper"

class NoTitleAttributeCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoTitleAttributeCounter
  end

  def test_warns_if_element_sets_title_and_has_no_counter_comment
    @file = "<img title='octopus'></img>"
    @linter.run(processed_source)

    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::NoTitleAttributeCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/The title attribute should never be used unless for an `<iframe>` as it is inaccessible for several groups of users./, error_messages.last)
  end

  def test_does_not_warns_if_element_sets_title_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoTitleAttributeCounter 1 %>
      <a href="/" title="bad">some website</a>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_warn_if_iframe_sets_title
    @file = "<iframe title='Introduction video'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoTitleAttributeCounter 1 %>
      <a href="/" title="bad">some website</a>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoTitleAttributeCounter 3 %>
      <a href="/" title="bad">some website</a>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoTitleAttributeCounter 1 %>
      <a href="/" title="bad">some website</a>
    ERB
    assert_equal expected_content, corrected_content
  end
end
