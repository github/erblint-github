# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoTitleAttributeCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "The title attribute should never be used unless for an `<iframe>` as it is inaccessible for several groups of users."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name == "iframe"
              next if tag.closing?

              title = possible_attribute_values(tag, "title")
              generate_offense(self.class, processed_source, tag) if title.present?
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
