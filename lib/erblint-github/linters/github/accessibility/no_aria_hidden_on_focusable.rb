# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoAriaHiddenOnFocusableCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "Elements that are focusable should not have `aria-hidden='true' because it will cause confusion for assistive technology users."
          
          class ConfigSchema < LinterConfig
            property :counter_enabled, accepts: [true, false], default: false, reader: :counter_enabled?
          end
          self.config_schema = ConfigSchema

          def run(processed_source)
            tags(processed_source).each do |tag|
              aria_hidden = possible_attribute_values(tag, "aria-hidden")
              generate_offense(self.class, processed_source, tag) if aria_hidden.include?("true") && focusable?(tag)
            end

            if @config.counter_enabled?
              counter_correct?(processed_source)
            end
          end
        end
      end
    end
  end
end
