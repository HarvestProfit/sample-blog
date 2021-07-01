require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "test@harvestprofit.com",
                        username: "testaccount", 
                        password: "testpass",
                        password_confirmation: "testpass")

    # @post = posts(:post_one, user: @user)
    @post_params = {post: {content_markdown: "A quick example blog postsdfsdasfsdaf chrissdfsd324f23s edited new onesdffdsfd", description: "This is an awesome descriptionlol", image_url: "https://images.unsplash.com/photo-1592136187769-65d502332dc6", title: "New Post Title"}}
    @authorization = JsonWebToken.encode(user_id: @user.id)
  end

  test "should get index" do
    2.times { create_post(@post_params) }

    get posts_url, headers: {Authorization: @authorization}, as: :json
    response_json = JSON.parse(response.body)

    assert(response_json.size == 2)
  end

  test "should create post" do
    assert_difference("Post.count") do
      create_post(@post_params)
    end

    post = get_post(response.body)

    assert(@user.id == post.user_id)
  end

  test "should show post" do
    create_post(@post_params)
    post = get_post(response.body)

    get post_url(post), headers: {Authorization: @authorization}, as: :json
    assert_response :success
  end

  test "should update post" do
    post_params_2 = {post: {content_markdown: "A quick example blog postsdfsdasfsdaf chrissdfsd324f23s edited new onesdffdsfd", description: "This is an awesome descriptionlol", image_url: "https://images.unsplash.com/photo-1592136187769-65d502332dc6", title: "EDITED TITLE"}}

    create_post(@post_params)
    post = get_post(response.body)

    patch post_url(post), params: post_params_2, headers: {Authorization: @authorization}, as: :json
    post.reload

    assert(post.title == "EDITED TITLE")
  end

  test "should destroy post" do
    create_post(@post_params)
    post = get_post(response.body)

    assert_difference("Post.count", -1) do
      delete post_url(post), headers: {Authorization: @authorization}, as: :json
    end

    assert_response 204
  end

  def get_post(response)
    Post.find(JSON.parse(response)['id'])
  end

  def create_post(params)
    post posts_url, params: params, headers: {Authorization: @authorization}, as: :json
  end
end
