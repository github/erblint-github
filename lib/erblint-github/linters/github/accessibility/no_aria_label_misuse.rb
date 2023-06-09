# frozen_string_literal: true

require_relative "../../custom_helpers"

module ERBLint
  module Linters
    module GitHub
      module Accessibility
        class NoAriaLabelMisuse < Linter
          include ERBLint::Linters::CustomHelpers
          include LinterRegistry

          GENERIC_ELEMENTS = %w[span div].freeze
          NAME_RESTRICTED_ELEMENTS = %w[h1 h2 h3 h4 h5 h6 strong i p b code].freeze

          # https://w3c.github.io/aria/#namefromprohibited
          ROLES_WHICH_CANNOT_BE_NAMED = %w[caption code definition deletion emphasis insertion mark none paragraph presentation strong subscript suggestion superscript term time].freeze

          MESSAGE = "[aria-label] and [aria-labelledby] usage are only reliably supported on interactive elements and a subset of ARIA roles"

          def run(processed_source)
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless possible_attribute_values(tag, "aria-label").present? || possible_attribute_values(tag, "aria-labelledby").present?

              if NAME_RESTRICTED_ELEMENTS.include?(tag.name)
                generate_offense(self.class, processed_source, tag)
              elsif GENERIC_ELEMENTS.include?(tag.name)
                role = possible_attribute_values(tag, "role")
                if role.present?
                  generate_offense(self.class, processed_source, tag) if ROLES_WHICH_CANNOT_BE_NAMED.include?(role.join)
                else
                  generate_offense(self.class, processed_source, tag)
                end
              end
            end
          end
        end
      end
    end
  end
end
