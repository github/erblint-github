# frozen_string_literal: true

require "test_helper"

class AriaLabelIsWellFormatted < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::AriaLabelIsWellFormatted
  end

  def test_warns_when_aria_label_starts_with_downcase
    @file = <<~HTML
     <button aria-label="submit" ></button>
     <button aria-label="check-box-1" ></button>
     <button aria-label="ok" ></button>
     <button aria-label="no" ></button>
     <button aria-label="Go to my&#10;website." ></button>
    HTML
    @linter.run(processed_source)

    assert_equal 5, @linter.offenses.count
  end

  def test_warns_when_aria_label_contains_newline_characer
    @file = <<~HTML
      <button aria-label="Go to my&#10;website." ></button>
      <button aria-label="Go to my\nwebsite." ></button>
    HTML
    @linter.run(processed_source)
    assert_equal 2, @linter.offenses.count
  end

  def test_does_not_warn_when_aria_labelledby_starts_with_downcase
    @file = "<button aria-labelledby='some-element-1'</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_with_string_interpolation
    @file = '<button aria-label="Add a cat <%= "or dog " if dog_allowed? %>pet"></button>'
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_when_aria_label_starts_with_anything_other_than_downcase
    @file = <<~HTML
     <button aria-label="Submit" ></button>
     <button aria-label="Close" ></button>
     <button aria-label="11 open" ></button>
    HTML
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_aria_label_is_in_excepted_list
    @file = <<~HTML
     <button aria-label="hello" ></button>
     <button aria-label="git checkout <%= some_branch %>"></button>
    HTML
    @linter.config.exceptions = ["hello", "git checkout <%= some_branch %>"]
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
