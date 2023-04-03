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

          class ConfigSchema < LinterConfig
            property :counter_enabled, accepts: [true, false], default: false, reader: :counter_enabled?
          end
          self.config_schema = ConfigSchema
          
          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name == "iframe"
              next if tag.closing?

              title = possible_attribute_values(tag, "title")
              generate_offense(self.class, processed_source, tag) if title.present?
            end

            if @config.counter_enabled?
              counter_correct?(processed_source)
            end
          end
        end
      end
    end
  end
end
