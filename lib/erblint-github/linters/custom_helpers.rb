# frozen_string_literal: true

require "json"
require "openssl"

module ERBLint
  module Linters
    module CustomHelpers
      def rule_disabled?(processed_source)
        processed_source.parser.ast.descendants(:erb).each do |node|
          indicator_node, _, code_node, = *node
          indicator = indicator_node&.loc&.source
          comment = code_node&.loc&.source&.strip
          rule_name = self.class.name.gsub("ERBLint::Linters::", "")

          if indicator == "#" && comment.start_with?("erblint:disable") && comment.match(rule_name)
            if @offenses.any?
              clear_offenses
            else
              add_offense(processed_source.to_source_range(code_node.loc),
                          "Unused erblint:disable comment for #{rule_name}")
            end
          end
        end
      end

      def generate_offense(klass, processed_source, tag, message = nil, replacement = nil)
        message ||= klass::MESSAGE
        klass_name = klass.name.demodulize
        offense = ["#{klass_name}:#{message}", tag.node.loc.source].join("\n")
        add_offense(processed_source.to_source_range(tag.loc), offense, replacement)
      end

      def possible_attribute_values(tag, attr_name)
        value = tag.attributes[attr_name]&.value || nil
        basic_conditional_code_check(value || "") || [value].compact
      end

      # Map possible values from condition
      def basic_conditional_code_check(code)
        conditional_match = code.match(/["'](.+)["']\sif|unless\s.+/) || code.match(/.+\s?\s["'](.+)["']\s:\s["'](.+)["']/)
        [conditional_match[1], conditional_match[2]].compact if conditional_match
      end

      def tags(processed_source)
        processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
      end

      def rule_disable_comment
        rule_name = self.class.name.gsub("ERBLint::Linters::", "")
        "<%# erblint:disable #{rule_name} %>\n"
      end

      # Allow linter violations to be bulk disabled by adding a comment on top of file
      def autocorrect(processed_source, offense)
        lambda do |corrector|
          corrector.insert_before(processed_source.source_buffer.source_range, rule_disable_comment) unless processed_source.file_content.include?(rule_disable_comment)
        end
      end
    end
  end
end
