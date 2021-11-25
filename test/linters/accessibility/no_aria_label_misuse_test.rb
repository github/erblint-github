# frozen_string_literal: true

require "test_helper"

class NoAriaLabelMisuseTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::NoAriaLabelMisuse
  end

  def example_invalid_case
    <<~HTML
      <span aria-labelledby='unique-id'>This is a span</span>
    HTML
  end

  def test_warns_if_banned_elements_have_aria_label
    @file = <<~HTML
      <h1 aria-label="some label"></h1>
      <h2 aria-labelledby="label1"></h2>
      <h3 aria-label="some label"></h3>
      <h4 aria-labelledby="label2"></h4>
      <h5 aria-label="some label"></h5>
      <h6 aria-labelledby="label3"></h6>
      <strong aria-label="some label"></strong>
      <i aria-labelledby="label5"></i>
      <p aria-label="some label"></p>
      <b aria-labelledby="label4"></b>
      <code aria-label="some label"></code>
    HTML

    @linter.run(processed_source)
    assert_equal @linter.offenses.length, 11
  end

  def test_warns_if_generic_elements_have_aria_label_and_no_role
    @file = <<~HTML
      <span aria-labelledby="unique-id">This is a span</span>
      <div aria-label="text">This is a div</div>
    HTML

    @linter.run(processed_source)
    assert_equal 2, @linter.offenses.length
  end

  def test_warns_if_generic_elements_have_aria_label_and_prohibited_role
    @file = <<~HTML
      <span role="caption" aria-labelledby="unique-id">This is a span</span>
      <div role="code" aria-label="text">This is a div</div>
      <span role="definition" aria-labelledby="unique-id">This is a span</span>
      <div role="deletion" aria-label="text">This is a div</div>
      <span role="insertion" aria-labelledby="unique-id">This is a span</span>
      <div role="mark" aria-label="text">This is a div</div>
      <span role="paragraph" aria-labelledby="unique-id">This is a span</span>
      <div role="presentation" aria-label="text">This is a div</div>
      <span role="strong" aria-labelledby="unique-id">This is a span</span>
      <div role="subscript" aria-label="text">This is a div</div>
      <span role="suggestion" aria-labelledby="unique-id">This is a span</span>
      <div role="superscript" aria-label="text">This is a div</div>
      <span role="term" aria-labelledby="unique-id">This is a span</span>
      <div role="time" aria-label="text">This is a div</div>
    HTML

    @linter.run(processed_source)
    assert_equal 14, @linter.offenses.length
  end

  def test_does_not_warn_if_generic_elements_have_aria_label_and_allowed_role
    @file = <<~HTML
      <div role="banner" aria-label="text"></div>
      <div role="button" aria-label="text 1"></div>
      <div role="combobox" aria-label="text 2"></div>
    HTML

    @linter.run(processed_source)
    assert_empty @linter.offenses
  end
end
