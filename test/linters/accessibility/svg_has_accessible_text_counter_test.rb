# frozen_string_literal: true

require "test_helper"

class SvgHasAccessibleTextCounter < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::SvgHasAccessibleTextCounter
  end

  def test_warns_if_svg_does_not_have_accesible_text
    @file = "<svg height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>"
    @linter.run(processed_source)
    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::SvgHasAccessibleTextCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/`<svg>` must have accessible text. Set `aria-label`, or `aria-labelledby`, or nest a `<title>` element. However, if the `<svg>` is purely decorative, hide it with `aria-hidden='true'./, error_messages.last)
  end

  def test_does_not_warn_if_svg_has_accesible_text
    @file = "<svg aria-label='A circle' height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>"
    @linter.run(processed_source)

    assert_empty @linter.offenses

    @file = "<svg aria-labelledby='test_id' height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>"
    @linter.run(processed_source)

    assert_empty @linter.offenses

    @file = "<svg height='100' width='100'><title>A circle</title><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_svg_has_accesible_text_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::SvgHasAccessibleTextCounter 1 %>
      <svg height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::SvgHasAccessibleTextCounter 1 %>
      <svg height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::SvgHasAccessibleTextCounter 3 %>
      <svg height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::SvgHasAccessibleTextCounter 1 %>
      <svg height='100' width='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red'/></svg>
    ERB
    assert_equal expected_content, corrected_content
  end
end
