# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class DetailsHasSummary < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "<details> elements need to have explict <summary> elements"

          def run(processed_source)
            current_details = nil
            has_summary = false

            tags(processed_source).each_with_index do |tag, index|
              if tag.name == "summary" && !tag.closing?
                has_summary = true
              end

              next if tag.name != "details"

              if tag.closing? && !has_summary
                generate_offense(self.class, processed_source, current_details)
                current_details = nil
              else
                current_details = tag
              end
            end

            rule_disabled?(processed_source)
          end
        end
      end
    end
  end
end
