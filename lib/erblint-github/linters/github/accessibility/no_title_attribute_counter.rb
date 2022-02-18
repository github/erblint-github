# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoTitleAttributeCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "The title attribute is inaccesible to several groups of users. Please avoid setting unless for an `<iframe>`."

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "iframe"
              next if tag.closing?

              title = possible_attribute_values(tag, "title")

              generate_offense(self.class, processed_source, tag) if title.present?
            end

            counter_correct?(processed_source)
          end

          private

          def correct_counter(corrector, processed_source, offense)
            if processed_source.file_content.include?("erblint:counter DeprecatedInPrimerCounter")
              corrector.replace(offense.source_range, offense.context)
            else
              corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
            end
          end

          def autocorrect(processed_source, offense)
            return unless offense.context
    
            lambda do |corrector|
              if offense.context.include?("erblint:counter DeprecatedInPrimerCounter")
                correct_counter(corrector, processed_source, offense)
              end
            end
          end
        end
      end
    end
  end
end
