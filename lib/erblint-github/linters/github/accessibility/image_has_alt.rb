# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class ImageHasAlt < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "<img> should have an alt prop with meaningful text or an empty string for decorative images"

          class ConfigSchema < LinterConfig
            property :counter_enabled, accepts: [true, false], default: false, reader: :counter_enabled?
          end
          self.config_schema = ConfigSchema

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.name != "img"
              next if tag.closing?

              alt = possible_attribute_values(tag, "alt")

              generate_offense(self.class, processed_source, tag) if alt.empty?
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
