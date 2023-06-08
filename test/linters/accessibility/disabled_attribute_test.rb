# frozen_string_literal: true

require "test_helper"

class DisabledAttributeTest < LinterTestCase
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
end
