# frozen_string_literal: true

require "test_helper"

class AvoidBothDisabledAndAriaDisabled < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::AvoidBothDisabledAndAriaDisabledCounter
  end

  ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT = %w[button fieldset input optgroup option select textarea].freeze

  def test_warns_if_both_disabled_and_aria_disabled_set_on_html_elements_with_disabled_support
    @file = ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.map do |element|
      "<#{element} aria-disabled='true' disabled> </#{element}>"
    end.join
    @linter.run(processed_source)

    assert_equal @linter.offenses.count, 8
  end

  def test_does_not_warn_if_only_disabled_attribute_is_set
    @file = ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.map do |element|
      "<#{element} disabled> </#{element}>"
    end.join
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_only_aria_disabled_attribute_is_set
    @file = ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.map do |element|
      "<#{element} aria-disabled='true'> </#{element}>"
    end.join
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_raise_when_ignore_comment_with_correct_count
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaDisabledCounter 1 %>
      <button disabled aria-disabled="true">Some text</span>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaDisabledCounter 1 %>
      <button disabled aria-disabled="true">Some text</button>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <button disabled aria-disabled="true">Some text</button>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaDisabledCounter 1 %>
      <button disabled aria-disabled="true">Some text</button>
    ERB
    assert_equal expected_content, corrected_content
  end
end
