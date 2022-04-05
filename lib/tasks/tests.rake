# frozen_string_literal: true

namespace :tests do
  task :coverage do
    require "erb_lint/all"
    require "erblint-github/linters"

    Dir[File.join("lib", "erblint-github", "linters", "github/**/*.rb")].sort.each do |file|
      test_path = file.gsub("lib/erblint-github/linters/github/", "test/linters/").gsub(".rb", "_test.rb")
      raise "Missing test. Please add test in #{test_path}" unless File.file?(test_path.to_s)
    end
    puts "All rules have test coverage."
  end
end
