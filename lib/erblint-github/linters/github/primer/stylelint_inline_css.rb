# frozen_string_literal: true

module ERBLint
  module Linters
    # :nodoc:
    class StylelintInlineCSS < Linter
      include LinterRegistry

      MESSAGE = ""

      def run(processed_source)
        tags(processed_source).each do |tag|
          next if tag.closing?
          next if tag.attributes["style"].nil?
          value = tag.attributes["style"].value
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

      private

      def tags(processed_source)
        processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
      end

      def simple_class_name
        self.class.name.gsub("ERBLint::Linters::", "")
      end

      def generate_offense(klass, processed_source, tag, message)
        offense = ["#{simple_class_name}:#{message}", tag.node.loc.source].join("\n")
        add_offense(processed_source.to_source_range(tag.loc), offense)
      end
    end
  end
end
