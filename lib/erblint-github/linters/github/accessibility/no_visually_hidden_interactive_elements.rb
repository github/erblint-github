# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoVisuallyHiddenInteractiveElements < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry
          INTERACTIVE_ELEMENTS = %w[a button summary select option textarea].freeze

          MESSAGE = "Avoid visually hidding interactive elements. Visually hiding interactive elements can be confusing to sighted keyboard users as it appears their focus has been lost when they navigate to the hidden element"

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              classes = possible_attribute_values(tag, "class")
              if classes.include?("sr-only") && INTERACTIVE_ELEMENTS.include?(tag.name)
                generate_offense(self.class, processed_source, tag)
              end
            end
          end
        end
      end
    end
  end
end
