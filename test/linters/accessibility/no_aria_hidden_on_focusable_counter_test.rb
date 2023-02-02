# frozen_string_literal: true

require "test_helper"

class NoAriaHiddenOnFocusableCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoAriaHiddenOnFocusableCounter
  end

  def test_does_not_warn_if_link_does_not_have_aria_hidden
    @file = "<a href='github.com'>GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_consider_aria_hidden_as_aria_hidden_true
    # aria-hidden is not the same as aria-hidden="true". Not ideal code.
    @file = "<a aria-hidden href='github.com'>GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_link_has_aria_hidden_false
    @file = "<a aria-hidden='false' href='github.com'>GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_when_link_has_aria_hidden_true_and_is_not_focusable
    @file = "<a aria-hidden='true' tabindex='-1' href='github.com'>GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_warns_when_element_has_aria_hidden_true_and_not_tab_focusable
    @file = "<div role='button' tabindex='0' aria-hidden='true'>GitHub</a>"
    @linter.run(processed_source)
    refute_empty @linter.offenses
  end

  def test_warns_when_link_has_aria_hidden_true
    @file = "<a aria-hidden='true' href='github.com'>GitHub</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_element_has_aria_hidden_true_and_is_tab_focusable
    @file = "<div role='list' aria-hidden='true' tabindex='0'></div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end
end
