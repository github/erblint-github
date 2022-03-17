# frozen_string_literal: true

require "test_helper"
require_relative "../../lib/erblint-github/linters/tag_tree_helpers"

class TagTreeHelpers < Minitest::Test
  include ERBLint::Linters::TagTreeHelpers

  def test_build_tree
    file = %{
      <html>
        <head>
          <title>Hello</title>
        </head>
        <body>
          <h1>Hello</h1>
          Welcome to my page!
        </body>
      </html>
    }
    processed_source = ERBLint::ProcessedSource.new("file.rb", file)
    tags, tree = build_tag_tree(processed_source)

    html_tag = tags.first

    assert_equal "html", html_tag.name

    children = tree[html_tag][:children].filter do |child|
      child[:tag].name
    end

    assert_equal 2, children.length
    assert_equal "head", children[0][:tag].name

    body_tag = children[1][:tag]
    assert_equal "body", body_tag.name

    h1_tag = tree[body_tag][:children].filter{ |child| child[:tag].name }.first[:tag]
    assert_equal "h1", h1_tag.name
  end
end
