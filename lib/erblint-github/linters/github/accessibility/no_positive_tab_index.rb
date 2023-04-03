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

          class ConfigSchema < LinterConfig
            property :counter_enabled, accepts: [true, false], default: false, reader: :counter_enabled?
          end
          self.config_schema = ConfigSchema
          
          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless tag.attributes["tabindex"]&.value.to_i.positive?

              generate_offense(self.class, processed_source, tag)
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
