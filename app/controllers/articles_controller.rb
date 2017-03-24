class ArticlesController < ApplicationController

  load_and_authorize_resource find_by: :slug


  def index
    @articles = Article.most_recent.includes(:user).page(params[:page])
    render(partial: 'previews', locals: { posts: @articles }) if request.xhr?
  end

  def by_tag
    @articles = Article.by_tag(params[:tag]).most_recent.includes(:user).page(params[:page])
    if request.xhr?
      render partial: 'previews', locals: { posts: @articles }
    else
      @total_count = Article.by_tag(params[:tag]).count
    end
    render :index
  end

end
