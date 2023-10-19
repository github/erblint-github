# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module Primer
      # :nodoc:
      class StylelintInlineCSS < Linter
        include ERBLint::Linters::CustomHelpers
        include LinterRegistry

        def run(processed_source)
          tags(processed_source).each do |tag|
            next if tag.closing?
            next if tag.attributes["style"].nil?
            value = tag.attributes["style"].value

            # Don't check values that are ERB
            next if value.match?(/[\<\%\{]/)

            css = ".div { #{value} }"
            output = JSON.parse(`echo "#{css}" | npx stylelint --stdin -f json`)

            if output[0]["errored"]
              output[0]["warnings"].each do |warning|
                rule = warning["rule"]
                text = warning["text"]
                generate_offense(self.class, processed_source, tag, "#{rule}: #{text}")
              end
            end
          end
        end
      end
    end
  end
end
