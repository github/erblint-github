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
end
