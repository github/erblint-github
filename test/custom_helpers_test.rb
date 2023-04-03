# frozen_string_literal: true

require "test_helper"
require "erblint-github/linters/custom_helpers"

class CustomHelpersTest < LinterTestCase
  include ERBLint::Linters::CustomHelpers

  class FakeLinter < ERBLint::Linter
    attr_accessor :offenses

    MESSAGE = "Please fix your code."
  end

  def linter_class
    CustomHelpersTest::FakeLinter
  end

  def extended_linter
    @linter.extend(ERBLint::Linters::CustomHelpers)
  end

  def test_counter_correct_does_not_add_offense_if_counter_matches_offense_count
    @file = <<~HTML
      <%# erblint:counter CustomHelpersTest::FakeLinter 1 %>
    HTML
    @linter.offenses = ["fake offense"]

    extended_linter.counter_correct?(processed_source)
    assert_empty @linter.offenses
  end

  def test_counter_correct_add_offense_if_counter_comment_is_unused
    @file = <<~HTML
      <%# erblint:counter CustomHelpersTest::FakeLinter 1 %>
    HTML

    extended_linter.counter_correct?(processed_source)
    assert_equal "Unused erblint:counter comment for CustomHelpersTest::FakeLinter", @linter.offenses.first.message
  end

  def test_counter_correct_add_offense_if_counter_comment_count_is_incorrect
    @file = <<~HTML
      <%# erblint:counter CustomHelpersTest::FakeLinter 2 %>
    HTML
    @linter.offenses = ["fake offense"]

    extended_linter.counter_correct?(processed_source)
    assert_equal "Incorrect erblint:counter number for CustomHelpersTest::FakeLinter. Expected: 2, actual: 1.", @linter.offenses.first.message
  end

  def test_generate_offense_with_message_defined_in_linter_class
    @file = <<~HTML
      <%# erblint:disable CustomHelpersTest::FakeLinter %>
      <div id="fake-div-id">Hello.</div>
    HTML
    assert_empty @linter.offenses

    tag = extended_linter.tags(processed_source).first
    extended_linter.generate_offense(CustomHelpersTest::FakeLinter, processed_source, tag)

    assert_equal @linter.offenses.length, 1
    assert_match CustomHelpersTest::FakeLinter::MESSAGE, @linter.offenses.first.message
  end

  def test_generate_offense_with_message_passed_in_as_parameter
    @file = <<~HTML
      <div id="fake-div-id">Hello.</div>
    HTML
    assert_empty @linter.offenses

    tag = extended_linter.tags(processed_source).first
    extended_linter.generate_offense(CustomHelpersTest::FakeLinter, processed_source, tag, "bad!")

    assert_equal @linter.offenses.length, 1
    assert_match(/bad!/, @linter.offenses.first.message)
  end

  def test_possible_attribute_values_returns_attribute_value_matches
    @file = <<~HTML
      <img alt="mona lisa">
      <button type="button"></button>
      <a></a>
    HTML

    image_tag = extended_linter.tags(processed_source).first
    image_tag_alt_values = extended_linter.possible_attribute_values(image_tag, "alt")
    assert_equal image_tag_alt_values, ["mona lisa"]

    button_tag = extended_linter.tags(processed_source)[1]
    button_tag_type_values = extended_linter.possible_attribute_values(button_tag, "type")
    assert_equal button_tag_type_values, ["button"]
  end

  def test_possible_attribute_values_returns_empty_array_if_no_attribute_value_matches
    @file = <<~HTML
      <a></a>
    HTML

    anchor_tag = extended_linter.tags(processed_source).first
    possible_attribute_values = extended_linter.possible_attribute_values(anchor_tag, "href")
    assert_equal possible_attribute_values, []
  end
end
