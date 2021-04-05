json.extract! post, :id, :title, :description, :image_url, :content_markdown, :content_html, :created_at, :updated_at
json.url post_url(post, format: :json)
