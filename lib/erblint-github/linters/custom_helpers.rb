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
