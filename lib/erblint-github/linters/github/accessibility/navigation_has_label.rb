# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NavigationHasLabel < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "The navigation landmark should have a unique accessible name via `aria-label` or `aria-labelledby`. Remember that the name does not need to include `navigation` or `nav` since it will already be announced."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless possible_attribute_values(tag, "role").include?("navigation") || tag.name == "nav"
              if possible_attribute_values(tag, "aria-label").empty? && possible_attribute_values(tag, "aria-labelledby").empty?
                message = MESSAGE
                if tag.name != "nav"
                  message += "Additionally, you can safely drop the `role='navigation'` and replace it with the native HTML `nav` element."
                end
                generate_offense(self.class, processed_source, tag, message)
              end

            end
          end
        end
      end
    end
  end
end
