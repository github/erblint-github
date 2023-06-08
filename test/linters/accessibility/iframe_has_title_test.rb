# frozen_string_literal: true

require "test_helper"

class IframeHasTitleTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::IframeHasTitle
  end

  def test_warns_if_iframe_has_no_title
    @file = "<iframe alt='image of an octopus'></iframe>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_iframe_has_aria_hidden_to_true
    @file = "<iframe aria-hidden='true'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_iframe_has_title_set_to_string
    @file = "<iframe title='Video tutorial of GitHub Actions'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
