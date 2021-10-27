# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "erblint-github"
  s.version = "0.0.1"
  s.summary = "erblint GitHub"
  s.description = "Template style checking for GitHub Ruby repositories"
  s.homepage = "https://github.com/github/erblint-github"
  s.license = "MIT"

  s.files = Dir["README.md", "LICENSE", "lib/**/*"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.5.0"

  s.email = ["opensource+erblint-github@github.com"]
  s.authors = ["GitHub Open Source"]

  s.add_development_dependency "erb_lint", "~> 0.1"
  s.add_development_dependency "minitest", "~> 5.14"
  s.add_development_dependency "mocha", "~> 1"
  s.add_development_dependency "rake", "~> 12.0"

  s.add_development_dependency "rubocop", "= 1.13.0"
  s.add_development_dependency "rubocop-github", "~> 0.16.0"
end
