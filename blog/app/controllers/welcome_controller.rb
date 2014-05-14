class WelcomeController < ApplicationController
  def index
    @pinnedposts = Post.published.pinned.order('id DESC').limit(1)
    @posts = Post.published.page(params[:page]).order('id DESC').limit(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end