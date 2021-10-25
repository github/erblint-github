# frozen_string_literal: true

Dir[File.join(__dir__, "linters", "github/**/*.rb")].sort.each { |file| require file }
