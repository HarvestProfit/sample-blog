class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  wrap_parameters :user, include: [:email, :username, :password, :password_confirmation]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
      UserMailer.welcome_to_blog_email(@user).deliver_later
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      token = JsonWebToken.encode({user_id: @user.id})
      return render json: {token: token}
    end
    render json: {error: "Username or Password not valid. Please try again."}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
