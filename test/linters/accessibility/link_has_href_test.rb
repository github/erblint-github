# frozen_string_literal: true

require "test_helper"

class LinkHasHrefTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LinkHasHref
  end

  def test_warns_if_link_has_no_href_attribute
    @file = "<a>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/Links should go somewhere, you probably want to use a `<button>` instead./, error_messages.last)
  end

  def test_does_not_warn_if_link_has_href_attribute
    @file = "<a href='https://github.com/'>Go to GitHub</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
