# frozen_string_literal: true

require "test_helper"

class DisabledAttributeCounter < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::DisabledAttributeCounter
  end

  def test_warns_if_invalid_element_has_disabled_attribute
    @file = "<a href='https://github.com/' disabled>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::DisabledAttributeCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/`disabled` is only valid on button, input, textarea, option, select, fieldset, optgroup, task-lists./, error_messages.last)
  end

  def test_does_not_warn_if_valid_element_has_disabled_attribute
    @file = "<button disabled>Continue</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_link_has_href_attribute_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::DisabledAttributeCounter 1 %>
      <a href='https://github.com/' disabled>Go to GitHub</a>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::DisabledAttributeCounter 1 %>
      <a href='https://github.com/' disabled>Go to GitHub</a>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::DisabledAttributeCounter 3 %>
      <a href='https://github.com/' disabled>Go to GitHub</a>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::DisabledAttributeCounter 1 %>
      <a href='https://github.com/' disabled>Go to GitHub</a>
    ERB
    assert_equal expected_content, corrected_content
  end
end
