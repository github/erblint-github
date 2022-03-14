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
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless tag.name == "details"

              # Find the details element index in the AST
              index = processed_source.ast.to_a.find_index(tag.node)

              # Get the next element in the AST
              next_node = processed_source.ast.to_a[index + 1]
              next_tag = BetterHtml::Tree::Tag.from_node(next_node)

              # If the next element is a summary, we're good
              next if next_tag.name == "summary"

              generate_offense(self.class, processed_source, tag)
            end

            rule_disabled?(processed_source)
          end
        end
      end
    end
  end
end
