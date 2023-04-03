# frozen_string_literal: true

require "test_helper"

class NestedInteractiveElementsTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NestedInteractiveElements
  end

  def test_warns_if_there_are_nested_interactive_elements
    @file = "<button><a href='https://github.com/'>Go to GitHub</a></button>"
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/Nesting interactive elements produces invalid HTML, and ssistive technologies, such as screen readers, might ignore or respond unexpectedly to such nested controls./, error_messages.last)
  end

  def test_does_not_warn_if_there_are_not_nested_interactive_elements
    @file = "<button>Confirm</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_there_are_not_nested_interactive_elements_and_has_correct_counter_comment_with_config_enabled
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 1 %>
      <button><a href='https://github.com/'>Go to GitHub</a></button>
    ERB
    @linter.config.counter_enabled = true
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end
end
