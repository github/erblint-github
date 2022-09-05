# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class IframeHasTitleCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "`<iframe>` with meaningful content should have a title attribute that identifies the content."\
                    " If `<iframe>` has no meaningful content, hide it from assistive technology with `aria-hidden='true'`."\

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "iframe"
              next if tag.closing?

              title = possible_attribute_values(tag, "title")

              generate_offense(self.class, processed_source, tag) if title.empty? && !aria_hidden?(tag)
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

          private

          def aria_hidden?(tag)
            tag.attributes["aria-hidden"]&.value&.present?
          end
        end
      end
    end
  end
end
