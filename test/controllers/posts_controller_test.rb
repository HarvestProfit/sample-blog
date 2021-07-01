require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)

    @post = posts(:post_one)
    @authorization = JsonWebToken.encode(user_id: @user.id)
  end

  test "should get index" do
    get posts_url, headers: {Authorization: @authorization}, as: :json
    response_json = JSON.parse(response.body)
    total = response.headers['Total']

    assert(total == Post.all.count.to_s)
    assert_not_empty(response_json)
  end

  test "should create post" do
    assert_difference("Post.count") do
      params = { content_markdown: "A quick example blog postsdfsdasfsdaf chrissdfsd324f23s edited new onesdffdsfd", description: "This is an awesome descriptionlol", image_url: "https://images.unsplash.com/photo-1592136187769-65d502332dc6", title: "New Post Title"}
      post posts_url, params: params, headers: {Authorization: @authorization}, as: :json
    end

    post = get_post(response.body)

    assert(@user.id == post.user_id)
    assert_not_empty(response.body)
    assert_response 201
  end

  test "should show post" do
    get post_url(@post), headers: {Authorization: @authorization}, as: :json
    assert_response :success
  end

  test "should update post" do
    post_params_2 = {content_markdown: "A quick example blog postsdfsdasfsdaf chrissdfsd324f23s edited new onesdffdsfd", description: "This is an awesome descriptionlol", image_url: "https://images.unsplash.com/photo-1592136187769-65d502332dc6", title: "EDITED TITLE"}

    patch post_url(@post), params: post_params_2, headers: {Authorization: @authorization}, as: :json

    @post.reload
    assert(@post.title == "EDITED TITLE")
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), headers: {Authorization: @authorization}, as: :json
    end

    assert_response 204
  end

  def get_post(response)
    Post.find(JSON.parse(response)['id'])
  end
end
