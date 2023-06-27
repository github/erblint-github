# frozen_string_literal: true

require "json"
require "openssl"

module ERBLint
  module Linters
    module CustomHelpers
      INTERACTIVE_ELEMENTS = %w[button summary input select textarea a].freeze

      def generate_offense(klass, processed_source, tag, message = nil, replacement = nil)
        message ||= klass::MESSAGE
        message += "\nLearn more at https://github.com/github/erblint-github#rules.\n"
        offense = ["#{simple_class_name}:#{message}", tag.node.loc.source].join("\n")
        add_offense(processed_source.to_source_range(tag.loc), offense, replacement)
      end

      def generate_offense_from_source_range(klass, source_range, message = nil, replacement = nil)
        message ||= klass::MESSAGE
        message += "\nLearn more at https://github.com/github/erblint-github#rules.\n"
        offense = ["#{simple_class_name}:#{message}", source_range.source].join("\n")
        add_offense(source_range, offense, replacement)
      end

      def possible_attribute_values(tag, attr_name)
        value = tag.attributes[attr_name]&.value || nil
        [value].compact
      end

      def counter_correct?(processed_source)
        comment_node = nil
        expected_count = 0
        rule_name = self.class.name.gsub("ERBLint::Linters::", "")
        offenses_count = @offenses.length

        processed_source.parser.ast.descendants(:erb).each do |node|
          indicator_node, _, code_node, = *node
          indicator = indicator_node&.loc&.source
          comment = code_node&.loc&.source&.strip

          if indicator == "#" && comment.start_with?("erblint:counter") && comment.match(rule_name)
            comment_node = node
            expected_count = comment.match(/\s(\d+)\s?$/)[1].to_i
          end
        end

        if offenses_count.zero?
          # have to adjust to get `\n` so we delete the whole line
          add_offense(processed_source.to_source_range(comment_node.loc.adjust(end_pos: 1)), "Unused erblint:counter comment for #{rule_name}", "") if comment_node
          return false
        end

        first_offense = @offenses[0]

        if comment_node.nil?
          add_offense(processed_source.to_source_range(first_offense.source_range), "#{rule_name}: If you must, add <%# erblint:counter #{rule_name} #{offenses_count} %> to bypass this check.", "<%# erblint:counter #{rule_name} #{offenses_count} %>")
        else
          clear_offenses
          add_offense(processed_source.to_source_range(comment_node.loc), "Incorrect erblint:counter number for #{rule_name}. Expected: #{expected_count}, actual: #{offenses_count}.", "<%# erblint:counter #{rule_name} #{offenses_count} %>") if expected_count != offenses_count
        end
      end

      # Map possible values from condition
      def basic_conditional_code_check(code)
        conditional_match = code.match(/["'](.+)["']\sif|unless\s.+/) || code.match(/.+\s?\s["'](.+)["']\s:\s["'](.+)["']/)
        [conditional_match[1], conditional_match[2]].compact if conditional_match
      end

      def tags(processed_source)
        processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
      end

      def simple_class_name
        self.class.name.gsub("ERBLint::Linters::", "")
      end

      def focusable?(tag)
        tabindex = possible_attribute_values(tag, "tabindex")
        if INTERACTIVE_ELEMENTS.include?(tag.name)
          tabindex.empty? || tabindex.first.to_i >= 0
        else
          tabindex.any? && tabindex.first.to_i >= 0
        end
      end
    end
  end
end
