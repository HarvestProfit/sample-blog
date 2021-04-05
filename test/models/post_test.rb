require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "that we can render markdown content" do
    estimated_html = "<p><strong>Bold</strong></p>"
    post = posts(:post_one)
    post.content_markdown = "**Bold**"
    assert_equal post.content_html.strip, estimated_html
  end
end
