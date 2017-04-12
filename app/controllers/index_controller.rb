class IndexController < ApplicationController

  layout '_basic', only: %i(signin signup forgot)

  def index
    @banners  = Banner.active.order(created_at: :desc)
    @posts    = Post.most_recent.includes(:user).page(params[:page])
  end

  def subscribe
    if @banner = Banner.find(params[:banner_id])
      @banner.emails.push(params[:email]) unless @banner.emails.include?(params[:email]) # TODO validate email
      @banner.save
    end
    redirect_back(fallback_location: root_path)
  end

end
