# frozen_string_literal: true

require "test_helper"

class NoRedundantImageAltCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoRedundantImageAltCounter
  end

  def test_warns_if_alt_contains_image
    @file = "<img alt='image of an octopus'></img>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_if_alt_contains_picture
    @file = "<img alt='picture of an octopus'></img>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_if_alt_contains_no_redundant_text
    @file = "<img alt='an octopus'></img>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_linter_is_disabled_in_file
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::NoRedundantImageAltCounter 1 %>
      <img alt='image of an octopus'></img>
    ERB

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end
end
