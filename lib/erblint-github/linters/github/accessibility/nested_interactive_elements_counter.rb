# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NestedInteractiveElementsCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          INTERACTIVE_ELEMENTS = %w[button summary input select textarea a].freeze
          MESSAGE = "Nesting interactive elements produces invalid HTML, and ssistive technologies, such as screen readers, might ignore or respond unexpectedly to such nested controls."

          def run(processed_source)
            last_interactive_element = nil
            tags(processed_source).each do |tag|
              next unless INTERACTIVE_ELEMENTS.include?(tag.name)

              last_interactive_element = nil if last_interactive_element && tag.name == last_interactive_element.name && tag.closing?
              next if tag.closing?

              if last_interactive_element
                next if last_interactive_element.name == "summary" && tag.name == "a"
                next if tag.name == "input" && tag.attributes["type"]&.value == "hidden"

                message = "Found <#{tag.name}> nested inside of <#{last_interactive_element.name}>.\n" + MESSAGE
                generate_offense(self.class, processed_source, tag, message)
              end

              last_interactive_element = tag unless tag&.name == "input"
            end

            counter_correct?(processed_source)
          end

          def autocorrect(processed_source, offense)
            return unless offense.context

            lambda do |corrector|
              if processed_source.file_content.include?("erblint:counter #{simple_class_name}")
                # update the counter if exists
                corrector.replace(offense.source_range, offense.context)
              else
                # add comment with counter if none
                corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
              end
            end
          end
        end
      end
    end
  end
end
