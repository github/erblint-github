# frozen_string_literal: true

require "test_helper"

class DisabledAttribute < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::DisabledAttribute
  end

  def test_warns_if_invalid_element_has_disabled_attribute
    @file = "<a href='https://github.com/' disabled>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
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
    @linter.config.counter_enabled = true
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end
end
