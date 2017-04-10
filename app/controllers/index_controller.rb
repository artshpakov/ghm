class IndexController < ApplicationController

  layout '_basic', only: %i(signin signup forgot)

  def index
    @posts = Post.most_recent.includes(:user).page(params[:page])
  end

end
