# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoTitleAttribute < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "The title attribute should never be used as it is inaccessible for several groups of users. Exceptions are provided for <iframe> and <link>."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name == "iframe" || tag.name == "link"
              next if tag.closing?

              title = possible_attribute_values(tag, "title")
              generate_offense(self.class, processed_source, tag) if title.present?
            end
          end
        end
      end
    end
  end
end
