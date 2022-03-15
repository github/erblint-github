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

          MESSAGE = "<details> elements need to have explict <summary> elements"

          def run(processed_source)
            has_summary = false

            (tags, tag_tree) = build_tag_tree(processed_source)

            tags.each do |tag|
              next if tag.name != "details" || tag.closing?

              details = tag_tree[tag]

              details[:children].each do |child|
                if child && child[:tag].name == "summary"
                  has_summary = true
                  break
                end
              end

              generate_offense(self.class, processed_source, details[:tag]) unless has_summary

              has_summary = false
            end

            rule_disabled?(processed_source)
          end
        end
      end
    end
  end
end
