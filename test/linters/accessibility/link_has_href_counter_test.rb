# frozen_string_literal: true

require "test_helper"

class LinkHasHrefCounter < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LinkHasHrefCounter
  end

  def test_warns_if_link_has_no_href_attribute
    @file = "<a>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/Links should go somewhere, you probably want to use a `<button>` instead./, error_messages.last)
  end

  def test_does_not_warn_if_link_has_href_attribute
    @file = "<a href='https://github.com/'>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_link_has_href_attribute_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 1 %>
      <a>Go to GitHub</a>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 1 %>
      <a>Go to GitHub</a>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 3 %>
      <a>Go to GitHub</a>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LinkHasHrefCounter 1 %>
      <a>Go to GitHub</a>
    ERB
    assert_equal expected_content, corrected_content
  end
end
