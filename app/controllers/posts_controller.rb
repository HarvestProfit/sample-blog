class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_posts, only: %i[update destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = paginate Post.all
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post Not Found' }, status: :not_found
  end

  # AUTHENTICATED BELOW HERE

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = @user

    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = @posts.where(id: params[:id]).first!
    if @post.update(post_params)
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post Not Found On Your Account' }, status: :not_found
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = @posts.where(id: params[:id]).first!
    @post.destroy
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post Not Found On Your Account' }, status: :not_found
  end

  private

  def get_decoded_token
    auth_header = request.headers["Authorization"]
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue NoMethodError
    nil
  rescue JWT::DecodeError
    nil
  end

  def invalid_auth
    render json: {error: "Invalid Authentication"}, status: :forbidden
  end

  def load_user
    @user = User.find(get_decoded_token.first["user_id"])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def authenticate_user
    if !get_decoded_token
      return invalid_auth
    end

    load_user
    invalid_auth unless @user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_posts
    @posts = @user.posts
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :description, :image_url, :content_markdown, :user_id)
  end
end
