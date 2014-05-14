class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    if params[:category]
       @posts = Post.published.where(category_id: params[:category]).page(params[:page]).order('id DESC')
    elsif params[:tag]
       @posts = Post.published.tagged_with(params[:tag]).page(params[:page]).order('id DESC')
    elsif params[:search]
       @posts = Post.published.text_search(params[:search]).page(params[:page]).order('id DESC')
    else
       @posts = Post.published.page(params[:page]).order('id DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  
  def upvote
    @post = Post.find(params[:id])
    @post.liked_by current_user
    redirect_to @post
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.punch(request)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :category_id, :user_id, :tag_list, :published)
    end
end