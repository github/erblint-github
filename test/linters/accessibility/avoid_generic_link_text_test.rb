# frozen_string_literal: true

require "test_helper"

class AvoidGenericLinkTextCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::AvoidGenericLinkText
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

  def test_warns_when_link_text_is_banned_text_with_punctuation_and_space
    @file = <<~ERB
      <a>Learn more!</a>
      <a>   read more.</a>
      <a>click  here.</a>
    ERB
    @linter.run(processed_source)

    refute_empty @linter.offenses
    # 3 offenses, 1 related to matching counter comment not present despite violations
    assert_equal 4, @linter.offenses.count
  end

  def test_does_not_warn_when_banned_text_is_part_of_more_text
    @file = "<a>Learn more about GitHub Stars</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_ignores_when_aria_label_with_variable_is_set_on_link_tag
    @file = <<~ERB
      <a aria-label="<%= tooltip_text %>">Learn more</a>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_flags_when_aria_label_does_not_include_visible_link_text
    @file = <<~ERB
      <a aria-label="GitHub Sponsors">Learn more</a>
    ERB
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_does_not_flag_when_aria_label_includes_visible_link_text
    @file = <<~ERB
      <a aria-label="Learn more about GitHub Sponsors.">Learn more.</a>
      <a aria-label="Learn more about GitHub Sponsors.">Learn more  </a>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_ignores_when_aria_labelledby_is_set_on_link_tag_since_cannot_be_evaluated_accurately_by_erb_linter
    @file = "<a aria-labelledby='someElement'>Click here</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_warns_when_link_rails_helper_text_is_banned_text
    @file = "<%= link_to('click here', redirect_url) %>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_when_link_rails_helper_text_is_banned_text_with_aria_description
    @file = <<~ERB
      <%= link_to('click here', redirect_url, 'aria-describedby': 'element123', id: 'redirect') %>
    ERB
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_ignores_when_link_rails_helper_text_is_banned_text_with_any_aria_label_attributes_since_cannot_be_evaluated_accurately_by_erb_linter
    @file = <<~ERB
      <%= link_to('learn more', redirect_url, 'aria-labelledby': 'element1234', id: 'redirect') %>
      <%= link_to('learn more', redirect_url, 'aria-label': some_variable, id: 'redirect') %>
      <%= link_to('learn more', redirect_url, 'aria-label': "Learn #{@variable}", id: 'redirect') %>
      <%= link_to('learn more', redirect_url, 'aria-label': 'learn more about GitHub', id: 'redirect') %>
      <%= link_to('learn more', redirect_url, aria: { label: 'learn more about GitHub' }, id: 'redirect') %>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_handles_files_with_various_links
    @file = <<~ERB
      <p>
        <a href="github.com" aria-label='Click here to learn more'>Click here</a>
        <%= link_to "learn more", billing_path, "aria-label": "something" %>
        <a href="github.com" aria-label='Some totally different text'>Click here</a>
        <a href="github.com" aria-labelledby='someElement'>Click here</a>
      </p>
      <p>
        <%= link_to "learn more", billing_path, aria: { label: "something" } %>
        <%= link_to "learn more", billing_path, aria: { describedby: "element123" } %>
        <%= link_to "learn more", billing_path, "aria-describedby": "element123" %>
      </p>
    ERB
    @linter.run(processed_source)

    refute_empty @linter.offenses
    # 3 offenses, 1 related to matching counter comment not present despite violations
    assert_equal 4, @linter.offenses.count
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
      <p>
        <a href="github.com" aria-label='Click here to learn more'>Click here</a>
        <a href="github.com" aria-label='Some totally different text'>Click here</a>
        <a href="github.com" aria-labelledby='someElement'>Click here</a>
      </p>
      <p>
        <%= link_to "learn more", billing_path, "aria-label": "something" %>
        <%= link_to "learn more", billing_path, aria: { label: "something" } %>
        <%= link_to "learn more", billing_path, aria: { describedby: "element123" } %>
        <%= link_to "learn more", billing_path, "aria-describedby": "element123" %>
      </p>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::AvoidGenericLinkTextCounter 3 %>
      <p>
        <a href="github.com" aria-label='Click here to learn more'>Click here</a>
        <a href="github.com" aria-label='Some totally different text'>Click here</a>
        <a href="github.com" aria-labelledby='someElement'>Click here</a>
      </p>
      <p>
        <%= link_to "learn more", billing_path, "aria-label": "something" %>
        <%= link_to "learn more", billing_path, aria: { label: "something" } %>
        <%= link_to "learn more", billing_path, aria: { describedby: "element123" } %>
        <%= link_to "learn more", billing_path, "aria-describedby": "element123" %>
      </p>
    ERB
    assert_equal expected_content, corrected_content
  end
end
