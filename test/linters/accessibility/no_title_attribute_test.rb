# frozen_string_literal: true

require "test_helper"

class NoTitleAttributeTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoTitleAttribute
  end

  def test_warns_if_element_sets_title
    @file = "<img title='octopus'></img>"
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/The title attribute should never be used unless for an `<iframe>` as it is inaccessible for several groups of users./, error_messages.last)
  end

  def test_does_not_warn_if_iframe_sets_title
    @file = "<iframe title='Introduction video'></iframe>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_link_sets_title
    @file = "<link rel='unapi-server' type='application/xml' title='unAPI' href='/unapi'/></link>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
