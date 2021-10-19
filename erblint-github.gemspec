# frozen_string_literal: true

Gem::Specification.new do |s|
    s.name = "erblint-github"
    s.version = "0.0.1"
    s.summary = "erblint GitHub"
    s.description = "Code style checking for GitHub Ruby repositories"
    s.homepage = "https://github.com/github/erblint-github"
    s.license = "MIT"
  
    s.files = Dir["README.md", "LICENSE"]
  
    s.required_ruby_version = ">= 2.5.0"
  
    s.email = ["opensource+erblint-github@github.com"]
    s.authors = ["GitHub Open Source"]
  end