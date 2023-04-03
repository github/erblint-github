# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoPositiveTabIndexCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "Do not use positive tabindex as it is error prone and can severely disrupt navigation experience for keyboard users"

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless tag.attributes["tabindex"]&.value.to_i.positive?

              generate_offense(self.class, processed_source, tag)
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
