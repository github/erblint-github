# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoRedundantImageAltCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "<img> alt prop should not contain `image` or `picture` as screen readers already announce the element as an image"
          REDUNDANT_ALT_WORDS = %w[image picture].freeze

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "img"
              next if tag.closing?

              alt = possible_attribute_values(tag, "alt").join
              next if alt.empty?

              generate_offense(self.class, processed_source, tag) if (alt.downcase.split & REDUNDANT_ALT_WORDS).any?
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
