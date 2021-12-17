# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "erb_lint/all"
require "minitest"
require "minitest/autorun"
require "mocha/minitest"
require "linter_test_case"
require "erblint-github/linters"
require "linters/support/shared_linter_tests"
