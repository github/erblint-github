# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class SvgHasAccessibleText < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          MESSAGE = "`<svg>` must have accessible text. Set `aria-label`, or `aria-labelledby`, or nest a `<title>` element. However, if the `<svg>` is purely decorative, hide it with `aria-hidden='true'.\nFor more info, see https://css-tricks.com/accessible-svgs/."

          def run(processed_source)
            current_svg = nil
            has_accessible_label = false

            tags(processed_source).each do |tag|
              # Checks whether tag is a <title> nested in an <svg>
              has_accessible_label = true if current_svg && tag.name == "title" && !tag.closing?

              next if tag.name != "svg"

              if tag.closing?
                generate_offense(self.class, processed_source, current_svg) unless has_accessible_label
                current_svg = nil
              elsif possible_attribute_values(tag, "aria-hidden").join == "true"
                has_accessible_label = true
                current_svg = tag
              else
                current_svg = tag
                aria_label = possible_attribute_values(tag, "aria-label").join
                aria_labelledby = possible_attribute_values(tag, "aria-labelledby").join

                has_accessible_label = aria_label.present? || aria_labelledby.present?
              end
            end
          end
        end
      end
    end
  end
end
