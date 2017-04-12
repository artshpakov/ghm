class Admin::BannersController < ApplicationController

  include AdminArea

  load_and_authorize_resource

  def index
    @banners = Banner.order(created_at: :desc)
  end

  def create
    Banner.create banner_params
    redirect_to admin_banners_path
  end

  def update
    @banner.update banner_params
    redirect_to admin_banners_path
  end


  protected

  def banner_params
    params.require(:banner).permit(:title, :text, :image, :color, :form, :active).tap do |hash|
      hash[:text] = hash[:text][0..99] if hash[:text].length>=100
      hash[:image] = ImageManager.store(hash[:image]) if hash[:image].present?
    end
  end

end
