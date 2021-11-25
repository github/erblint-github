# frozen_string_literal: true

# This requires
module SharedLinterTests
  def linter_name
    linter_class.name.gsub("ERBLint::Linters::", "")
  end

  def test_does_not_warn_if_linter_is_disabled_in_file
    @file = <<~HTML
      <%# erblint:disable #{linter_name} %>
      #{example_invalid_case}
    HTML

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_autocorrects_with_disable_comment
    @file = <<~HTML
      #{example_invalid_case}
    HTML

    expected = <<~HTML
      <%# erblint:disable #{linter_name} %>
      #{example_invalid_case}
    HTML
    assert_equal expected, corrected_content
  end

  def test_does_not_autocorrect_with_disable_comment_if_comment_already_present
    @file = <<~HTML
      <%# erblint:disable #{linter_name} %>
      #{example_invalid_case}
    HTML

    expected = <<~HTML
      <%# erblint:disable #{linter_name} %>
      #{example_invalid_case}
    HTML
    assert_equal expected, corrected_content
  end
end
