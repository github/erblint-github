# frozen_string_literal: true

require "test_helper"

class StylelintInlineCSSTest < LinterTestCase
  def linter_class
    ERBLint::Linters::StylelintInlineCSS
  end

  def test_lints_with_stylelint
    @file = "<button style='color:red;'>Continue</button>"
    @linter.run(processed_source)
    assert_empty @linter.offenses
  end

  def test_doesnt_lint_with_ruby_syntax
    @file = "<li class=\"my-2\" style=\"padding-left: <%= entry[:level] * 12 %>px;\"></li>"
  end
end
