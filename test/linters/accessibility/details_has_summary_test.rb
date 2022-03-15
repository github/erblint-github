# frozen_string_literal: true

require "test_helper"

class DetailsHasSummary < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::DetailsHasSummary
  end

  def test_warns_if_details_doesnt_have_a_summary
    @file = "<details>I don't have a summary element</details>"
    @linter.run(processed_source)

    assert_equal @linter.offenses.count, 1
  end

  def test_does_not_warn_if_details_has_a_summary_in_a_weird_place
    @file = "<details><p>Surprise text!</p><summary>Expand me!</summary></details>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_details_has_a_summary
    @file = "<details><summary>Expand me!</summary><button>Surprise button!</button></details>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
