# frozen_string_literal: true

require "test_helper"

class LandmarkHasLabelTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LandmarkHasLabel
  end

  def test_warns_if_navigation_landmark_has_no_label
    @file = <<~ERB
      <nav>
      </nav>
    ERB
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    assert_match(/The navigation landmark should have a unique accessible name via `aria-label` or `aria-labelledby`./, @linter.offenses.first.message)
  end

  def test_warns_if_navigation_role_landmark_has_no_label
    @file = <<~ERB
      <div role="navigation">
      </div>
    ERB
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    assert_match(/The navigation landmark should have a unique accessible name via `aria-label` or `aria-labelledby`./, @linter.offenses.first.message)
  end

  def test_does_not_warn_if_navigation_landmark_has_aria_labelled_by
    @file = <<~ERB
      <nav aria-labelledby="title_id"t>
      </nav>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_navigation_landmark_has_aria_label
    @file = <<~ERB
      <nav aria-label="Repos"t>
      </nav>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
