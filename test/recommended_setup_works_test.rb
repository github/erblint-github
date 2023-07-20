# frozen_string_literal: true

require "test_helper"

class RecommendedSetupWorksTest < LinterTestCase
  # The ability to share rules and configs from other gems in erb_lint is not well-documented.
  # This test validates that our recommended setup works.
  def test_asserts_recommended_setup_works
    erb_lint_config = ERBLint::RunnerConfig.new(file_loader.yaml(".erb-lint.yml"), file_loader)

    rules_enabled_in_accessibility_config = 0
    erb_lint_config.to_hash["linters"].each do |linter|
      if linter[0].include?("GitHub::Accessibility") && linter[1]["enabled"] == true
        rules_enabled_in_accessibility_config += 1
      end
    end
    known_linter_names ||= ERBLint::LinterRegistry.linters.map(&:simple_name)

    assert_equal 16, rules_enabled_in_accessibility_config
    assert_equal 16, known_linter_names.count { |linter| linter.include?("GitHub::Accessibility") }
  end
end
