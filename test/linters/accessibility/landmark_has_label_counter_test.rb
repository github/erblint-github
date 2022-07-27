# frozen_string_literal: true

require "test_helper"

class LandmarkHasLabelCounter < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LandmarkHasLabelCounter
  end

  def test_warns_if_landmark_has_no_label
    @file = <<~ERB
      <section>
        <h1>This is a text</h1>
      </section>
    ERB
    @linter.run(processed_source)

    assert_equal(2, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
    assert_match(/If you must, add <%# erblint:counter GitHub::Accessibility::LandmarkHasLabelCounter 1 %> to bypass this check./, error_messages.first)
    assert_match(/Landmark elements should have an aria-label attribute, or aria-labelledby if a heading elements exists in the landmark./, error_messages.last)
  end

  def test_does_not_warn_if_landmark_has_label
    @file = <<~ERB
      <section aria-labelledby="title_id"t>
        <h1 id="title_id">This is a text</h1>
      </section>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_warn_if_landmark_has_label_and_has_correct_counter_comment
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LandmarkHasLabelCounter 1 %>
       <section>
        <h1>This is a text</h1>
      </section>
    ERB
    @linter.run(processed_source)

    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_autocorrect_when_ignores_are_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LandmarkHasLabelCounter 1 %>
       <section>
        <h1>This is a text</h1>
      </section>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LandmarkHasLabelCounter 3 %>
       <section>
        <h1>This is a text</h1>
      </section>
    ERB
    refute_equal @file, corrected_content

    expected_content = <<~ERB
      <%# erblint:counter GitHub::Accessibility::LandmarkHasLabelCounter 1 %>
       <section>
        <h1>This is a text</h1>
      </section>
    ERB
    assert_equal expected_content, corrected_content
  end
end
