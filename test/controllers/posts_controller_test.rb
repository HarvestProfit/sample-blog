require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:post_one)
  end

  test "should get index" do
    get posts_url, as: :json
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: {post: {content_markdown: @post.content_markdown, description: @post.description, image_url: @post.image_url, title: @post.title}}, as: :json
    end

    assert_response 201
  end

  test "should show post" do
    get post_url(@post), as: :json
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: {post: {content_markdown: @post.content_markdown, description: @post.description, image_url: @post.image_url, title: @post.title}}, as: :json
    assert_response 200
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), as: :json
    end

    assert_response 204
  end
end
