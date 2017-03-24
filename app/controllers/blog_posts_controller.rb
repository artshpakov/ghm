class BlogPostsController < ApplicationController

  before_action :check_authentication, only: :new
  before_action :load_blog
  load_and_authorize_resource find_by: :slug, except: :create


  def index
    @blog_posts = @blog.posts.most_recent.page(params[:page])
    render(partial: 'previews', locals: { posts: @blog_posts }) if request.xhr?
  end


  private

  def load_blog
    @blog = Blog.find(params[:blog_id])
  end

end
