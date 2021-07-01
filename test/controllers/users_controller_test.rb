require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "test@harvestprofit.com",
      username: "testaccount", 
      password: "testpass",
      password_confirmation: "testpass")
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'testemail@harvestprofit.com', password: 'secret', password_confirmation: 'secret', username: 'testaccount3' } }, as: :json
    end
    
    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, password: 'secret', password_confirmation: 'secret', username: 'NewUserName' } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end

  test "should login user" do
    post '/login', params: {username: @user.username, password: @user.password}, as: :json
    token = JSON.parse(response.body)["token"]  
    payload = JsonWebToken.decode(token)
    user_id = payload.first["user_id"]

    assert(@user.id == user_id)
  end
end
