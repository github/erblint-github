# frozen_string_literal: true

require "test_helper"

class NoPositiveTabIndexCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoPositiveTabIndexCounter
  end

  def test_warns_if_positive_tabindex_is_used
    @file = "<button tabindex='1'></button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_negative_tabindex_is_used
    @file = "<button tabindex='-1'></button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_zero_tabindex_is_used
    @file = "<button tabindex='0'></button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_raise_when_ignore_comment_with_correct_count
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoPositiveTabIndexCounter 1 %>
      <button tabindex='1'></button>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoPositiveTabIndexCounter 1 %>
      <button tabindex='1'></button>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <button tabindex='1'></button>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoPositiveTabIndexCounter 1 %>
      <button tabindex='1'></button>
    ERB
    assert_equal expected_content, corrected_content
  end
end
