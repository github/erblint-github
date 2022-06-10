# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList[ENV.fetch("TESTS", "test/**/*_test.rb")]
end

Rake.add_rakelib "lib/tasks"

desc "Run tests"
task default: :test
