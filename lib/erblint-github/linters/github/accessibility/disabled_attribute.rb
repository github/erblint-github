# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class DisabledAttribute < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          VALID_DISABLED_TAGS = %w[button input textarea option select fieldset optgroup task-lists].freeze
          MESSAGE = "`disabled` is only valid on #{VALID_DISABLED_TAGS.join(', ')}."

          class ConfigSchema < LinterConfig
            property :counter_enabled, accepts: [true, false], default: false, reader: :counter_enabled?
          end
          self.config_schema = ConfigSchema

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next if VALID_DISABLED_TAGS.include?(tag.name)
              next if tag.attributes["disabled"].nil?

              generate_offense(self.class, processed_source, tag)
            end

            if @config.counter_enabled?
              counter_correct?(processed_source)
            end
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
