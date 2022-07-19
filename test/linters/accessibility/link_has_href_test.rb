# frozen_string_literal: true

require "test_helper"

class LinkHasHref < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LinkHasHref
  end

  def test_warns_if_link_has_no_href_attribute
    @file = "<a>Go to GitHub</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_link_has_href_attribute
    @file = "<a href='https://github.com/'>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
