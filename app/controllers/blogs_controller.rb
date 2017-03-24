class BlogsController < ApplicationController

  before_action :check_authentication, :find_blog, only: %i(follow unfollow)


  def index
    @recent   = Blog.recent
    @trending = Blog.trending
    @promoted = Blog.promoted
  end

  def follow
    Following.create(object_id: @blog.user.id, follower_id: current_user.id) unless @blog.is_followed_by?(current_user)
    redirect_to :back
  end

  def unfollow
    Following.where(object_id: @blog.user.id, follower_id: current_user.id).delete_all
    redirect_to :back
  end


  private

  def find_blog
    @blog = Blog.find(params[:blog_id])
  end

end
