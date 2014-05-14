class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @postspublished = @user.posts.published.where(:user_id => params[:id])
    @postsunpublished = @user.posts.unpublished.where(:user_id => params[:id])
  end
end
