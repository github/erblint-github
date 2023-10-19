# frozen_string_literal: true

require "test_helper"

class NoVisuallyHiddenInteractiveElements < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoVisuallyHiddenInteractiveElements
  end

  def test_warns_if_element_is_interactive_and_visually_hidden
    @file = "<button class='sr-only'>Text</button>"
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/Avoid visually hidding interactive elements. Visually hiding interactive elements can be confusing to sighted keyboard users as it appears their focus has been lost when they navigate to the hidden element/, error_messages.last)
  end

  def test_does_not_warn_if_element_is_not_interactive_and_visually_hidden
    @file = "<div class='sr-only'>Text</div>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end


  def test_does_not_warn_if_element_is_interactive_and_not_visually_hidden
    @file = "<button class='other'>Submit</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_element_is_interactive_and_shown_on_focus
    @file = "<a class='other show-on-focus'>skip to main content</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_on_unexpected_elements
    @file = <<~ERB
      <span class="sr-only"></span>
      <button></button>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
