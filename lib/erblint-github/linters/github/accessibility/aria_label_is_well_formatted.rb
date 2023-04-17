# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class AriaLabelIsWellFormatted < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "[aria-label] text should be formatted the same as you would visual text. Use sentence case, and don't format it like an ID. Additionally, `aria-label` should be concise and should not contain line breaks."

          class ConfigSchema < LinterConfig
            property :exceptions, accepts: array_of?(String),
              default: -> { [] }
          end
          self.config_schema = ConfigSchema

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?

              aria_label = possible_attribute_values(tag, "aria-label").join

              if (aria_label.start_with?(/^[a-z]/) || aria_label.match?(/[\r\n]+/)) && !@config.exceptions.include?(aria_label)
                generate_offense(self.class, processed_source, tag)
              end
            end
          end
        end
      end
    end
  end
end
