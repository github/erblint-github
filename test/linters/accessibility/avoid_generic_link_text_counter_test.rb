# frozen_string_literal: true

require "test_helper"

class AvoidGenericLinkTextCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::AvoidGenericLinkTextCounter
  end

  def test_warns_when_link_text_is_click_here
    @file = "<a>Click here</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_link_text_is_learn_more
    @file = "<a>Learn more</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_link_text_is_read_more
    @file = "<a>Read more</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_link_text_is_more
    @file = "<a>More</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_link_text_is_link
    @file = "<a>Link</a>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_when_banned_text_is_part_of_more_text
    @file = "<a>Learn more about GitHub Stars</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_warns_when_link_rails_helper_text_is_banned_text
    @file = "<%= link_to('click here', redirect_url, id: 'redirect') %>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_warn_when_generic_text_is_link_rails_helper_sub_text
    @file = "<%= link_to('click here to learn about github', redirect_url, id: 'redirect') %>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warns_if_element_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidGenericLinkTextCounter 1 %>
      <a>Link</a>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_autocorrects_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidGenericLinkTextCounter 2 %>
      <a>Link</a>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidGenericLinkTextCounter 1 %>
      <a>Link</a>
    ERB
    assert_equal expected_content, corrected_content
  end
end
