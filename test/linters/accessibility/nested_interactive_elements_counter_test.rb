# frozen_string_literal: true

require "test_helper"

class NestedInteractiveElementsCounter < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NestedInteractiveElementsCounter
  end

  def test_warns_if_there_are_nested_interactive_elements
    @file = "<button><a href='https://github.com/'>Go to GitHub</a></button>"
    @linter.run(processed_source)

    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/Nesting interactive elements produces invalid HTML, and ssistive technologies, such as screen readers, might ignore or respond unexpectedly to such nested controls./, error_messages.last)
  end

  def test_does_not_warn_if_there_are_not_nested_interactive_elements
    @file = "<button>Confirm</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_there_are_not_nested_interactive_elements_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 1 %>
      <button><a href='https://github.com/'>Go to GitHub</a></button>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 1 %>
      <button><a href='https://github.com/'>Go to GitHub</a></button>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 3 %>
      <button><a href='https://github.com/'>Go to GitHub</a></button>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NestedInteractiveElementsCounter 1 %>
      <button><a href='https://github.com/'>Go to GitHub</a></button>
    ERB
    assert_equal expected_content, corrected_content
  end
end
