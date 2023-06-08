# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class LinkHasHref < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "Links should go somewhere, you probably want to use a `<button>` instead."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "a"
              next if tag.closing?

              href = possible_attribute_values(tag, "href")
              name = tag.attributes["name"]
              generate_offense(self.class, processed_source, tag) if (!name && href.empty?) || href.include?("#")
            end
          end
        end
      end
    end
  end
end
