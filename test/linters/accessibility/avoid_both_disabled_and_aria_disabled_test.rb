# frozen_string_literal: true

require "test_helper"

class AvoidBothDisabledAndAriaDisabled < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled
  end

  ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT = %w[button fieldset input optgroup option select textarea].freeze

  def test_warns_if_both_disabled_and_aria_disabled_set_on_html_elements_with_disabled_support
    @file = ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.map do |element|
      "<#{element} aria-disabled='true' disabled> </#{element}>"
    end.join
    @linter.run(processed_source)

    assert_equal @linter.offenses.count, 7
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

  def test_adds_extra_offense_to_add_counter_comment_if_counter_config_enabled
    @file = ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.map do |element|
      "<#{element} aria-disabled='true' disabled> </#{element}>"
    end.join
    @linter.config.counter_enabled = true
    @linter.run(processed_source)

    assert_equal @linter.offenses.count, 8
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaDisabled 7 %> to bypass this check/, @linter.offenses.last.message)
  end

  def test_does_not_raise_when_ignore_comment_with_correct_count_if_counter_enabled
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidBothDisabledAndAriaDisabledCounter 1 %>
      <button disabled aria-disabled="true">Some text</button>
    ERB
    @linter.config.counter_enabled = true
    @linter.run(processed_source)
    assert_empty @linter.offenses
  end
end
