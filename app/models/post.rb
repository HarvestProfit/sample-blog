require "github/markup"

class Post < ApplicationRecord
  def content_html
    return nil unless content_markdown
    GitHub::Markup.render_s(
      GitHub::Markups::MARKUP_MARKDOWN,
      content_markdown
    )
  end
end
