# frozen_string_literal: true

require "test_helper"

class LandmarkHasLabelTest < LinterTestCase
  def linter_class
    ERBLint::Linters::GitHub::Accessibility::LandmarkHasLabel
  end

  def test_warns_if_landmark_has_no_label
    @file = <<~ERB
      <section>
        <h1>This is a text</h1>
      </section>
    ERB
    @linter.run(processed_source)

    assert_equal(1, @linter.offenses.count)
    error_messages = @linter.offenses.map(&:message).sort
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
end
