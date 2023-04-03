# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class ImageHasAltCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "<img> should have an alt prop with meaningful text or an empty string for decorative images"

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "img"
              next if tag.closing?

              alt = possible_attribute_values(tag, "alt")

              generate_offense(self.class, processed_source, tag) if alt.empty?
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
