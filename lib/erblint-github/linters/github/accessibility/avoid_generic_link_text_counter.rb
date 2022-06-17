# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class AvoidGenericLinkTextCounter < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          BANNED_GENERIC_TEXT = [
            "Read more",
            "Learn more",
            "Click here",
            "More",
            "Link",
            "Here"
          ].freeze
          MESSAGE = "Avoid using generic link text such as #{BANNED_GENERIC_TEXT.join(', ')} which do not make sense in isolation."

          def run(processed_source)
            processed_source.ast.children.each_with_index do |node, index|
              next unless node.methods.include?(:type) && node.type == :text

              text = node.children.join.strip
              # Checks HTML tags
              if banned_text?(text)
                prev_node = processed_source.ast.children[index - 1]
                next_node = processed_source.ast.children[index + 1]

                next unless tag_type?(prev_node) && tag_type?(next_node)

                text_node_tag = BetterHtml::Tree::Tag.from_node(node)
                prev_node_tag = BetterHtml::Tree::Tag.from_node(prev_node)
                next_node_tag = BetterHtml::Tree::Tag.from_node(next_node)

                aria_label = possible_attribute_values(prev_node_tag, "aria-label")
                aria_labelledby = possible_attribute_values(prev_node_tag, "aria-labelledby")

                # We only report if the text is nested between two link tags.
                if link_tag?(prev_node_tag) && link_tag?(next_node_tag) && next_node_tag.closing?
                  # Cannot statically check label from aria-labelledby or label from variable aria-label so we skip
                  next if aria_labelledby.present? || (aria_label.present? && aria_label.join.include?("<%="))
                  next if aria_label.present? && valid_accessible_name?(aria_label.join, text)

                  range = prev_node_tag.loc.begin_pos...text_node_tag.loc.end_pos
                  source_range = processed_source.to_source_range(range)
                  generate_offense_from_source_range(self.class, source_range)
                end
              end

              # Checks Rails link helpers like `link_to`
              erb_node = node.type == :erb ? node : node.descendants(:erb).first
              next unless erb_node

              _, _, code_node = *erb_node
              source = code_node.loc.source
              ruby_node = extract_ruby_node(source)
              send_node = ruby_node&.descendants(:send)&.first
              next unless send_node.methods.include?(:method_name) && send_node.method_name == :link_to

              banned_text = nil

              send_node.child_nodes.each do |child_node|
                banned_text = child_node.children.join if child_node.methods.include?(:type) && child_node.type == :str && banned_text?(child_node.children.join)

                next unless banned_text.present? && child_node.methods.include?(:type) && child_node.type == :hash

                child_node.descendants(:pair).each do |pair_node|
                  next unless pair_node.children.first.type?(:sym)

                  # Don't flag if link has aria-labelledby which we cannot evaluate with ERB alone.
                  banned_text = nil if pair_node.children.first.children.join == "aria-labelledby" || pair_node.children.first.children.join == "aria-label"
                  next unless pair_node.children.first.children.join == "aria-label"

                  aria_label_value_node = pair_node.children[1]
                  if aria_label_value_node.type == :str
                    binding.irb
                    aria_label_text = aria_label_value_node.children.join
                    banned_text = nil if valid_accessible_name?(aria_label_text, banned_text)
                  else
                    # Don't flag if aria-label is not string (e.g. is a variable) since we cannot evaluate with ERB alone.
                    banned_text = nil
                  end
                end
              end
              if banned_text.present?
                tag = BetterHtml::Tree::Tag.from_node(code_node)
                generate_offense(self.class, processed_source, tag)
              end
            end
            counter_correct?(processed_source)
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

          private

          def banned_text?(text)
            BANNED_GENERIC_TEXT.map(&:downcase).include?(text.downcase)
          end

          # We flag if accessible name does not start with visible text.
          # Related: Success Criteria 2.5.3
          def valid_accessible_name?(accessible_name, visible_text)
            accessible_name.downcase.start_with?(visible_text.downcase)
          end

          def extract_ruby_node(source)
            BetterHtml::TestHelper::RubyNode.parse(source)
          rescue ::Parser::SyntaxError
            nil
          end

          def link_tag?(tag_node)
            tag_node.name == "a"
          end

          def tag_type?(node)
            node.methods.include?(:type) && node.type == :tag
          end
        end
      end
    end
  end
end
