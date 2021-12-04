# frozen_string_literal: true

namespace :docs do
  task :coverage do
    require "erb_lint/all"
    require "erblint-github/linters"

    Dir[File.join(__dir__, "linters", "github/**/*.rb")].sort.each do |file|
      rule_documentation_path = file
                                .gsub("#{__dir__}linters/github/", "docs/rules/")
                                .gsub(".rb", ".md")
                                .tr("_", "-")
      raise "Missing rule documentation. Please document rule in #{rule_documentation_path}" unless File.file?(rule_documentation_path.to_s)
    end
    puts "All rules have been properly documented."
  end
end
