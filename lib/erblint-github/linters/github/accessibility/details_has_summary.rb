# frozen_string_literal: true

require_relative "../../custom_helpers"
require_relative "../../tag_tree_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class DetailsHasSummary < Linter
          include ERBLint::Linters::CustomHelpers
          include ERBLint::Linters::TagTreeHelpers
          include LinterRegistry

          MESSAGE = "<details> elements need to have explicit <summary> element"

          def run(processed_source)
            has_summary = false

            (tags, tag_tree) = build_tag_tree(processed_source)

            tags.each do |tag|
              next if tag.name != "details" || tag.closing?

              details = tag_tree[tag]

              details[:children].each do |child|
                if child[:tag].name == "summary"
                  has_summary = true
                  break
                end

                erb_nodes = extract_erb_nodes(child[:tag].node)

                next if erb_nodes.blank?

                code = ""

                erb_nodes.each do |erb_node|
                  _, _, code_node = *erb_node
                  code += code_node.children.first
                end

                ast = erb_ast(code)

                ast = ast.children.first if ast.type == :block
                next unless ast.method_name == :content_tag

                if ast.arguments.first.value.to_s == "summary"
                  has_summary = true
                  break
                end
              end

              generate_offense(self.class, processed_source, details[:tag]) unless has_summary

              has_summary = false
            end

            rule_disabled?(processed_source)
          end

          private

          def extract_erb_nodes(node)
            return node if node.type == :erb
            return nil unless node.type == :text

            node.children.select { |x| x.try(:type) == :erb }
          end

          def erb_ast(code)
            RuboCop::AST::ProcessedSource.new(code, RUBY_VERSION.to_f).ast
          end
        end
      end
    end
  end
end
