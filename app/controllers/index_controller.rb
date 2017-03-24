class IndexController < ApplicationController

  layout '_basic', only: %i(signin signup forgot)

  def index
    @posts = if logged_in?
      followed = current_user.follows.select(:id)
      Post.where(user_id: followed.map(&:id)+[current_user.id]).or(Post.where(kind: 'Article'))
    else
      Post.all
    end.most_recent.includes(:user).page(params[:page])
  end

end
