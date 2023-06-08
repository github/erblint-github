# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class AvoidBothDisabledAndAriaDisabled < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT = %w[button fieldset input optgroup option select textarea].freeze
          MESSAGE = "[aria-disabled] may be used in place of native HTML [disabled] to allow tab-focus on an otherwise ignored element. Setting both attributes is contradictory."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless ELEMENTS_WITH_NATIVE_DISABLED_ATTRIBUTE_SUPPORT.include?(tag.name)
              next unless tag.attributes["disabled"] && tag.attributes["aria-disabled"]

              generate_offense(self.class, processed_source, tag)
            end
          end
        end
      end
    end
  end
end
