# frozen_string_literal: true

class LinterTestCase < Minitest::Test
  def setup
    @linter = linter_class&.new(file_loader, linter_class.config_schema.new)
  end

  def linter_class
    raise NotImplementedError
  end

  def offenses
    @linter.offenses
  end

  def file_loader
    ERBLint::FileLoader.new(".")
  end

  def processed_source
    ERBLint::ProcessedSource.new("file.rb", @file)
  end

  def tags
    processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
  end
end
