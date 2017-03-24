class ProfileController < ApplicationController

  layout '_wide'

  before_action :require_login


  def update
    flash.now[:error] = current_user.errors.messages unless current_user.update(profile_params)
    render :show
  end

  def password
    current_id = current_user.id
    if user = login(current_user.email, params[:old_password])
      user.set_password params[:password], params[:password_confirmation]
      flash.now[:error] = current_user.errors.messages unless user.save
    else
      auto_login User.find(current_id)
      flash.now[:error] = { error: t("auth.error.invalid_password") }
    end
    render :show
  end

  def avatar
    current_user.update avatar: params[:image]
    redirect_to profile_path
  end


  protected

  def profile_params
    params.permit(:email, profile: [:firstname, :lastname]).to_h.tap do |attrs|
      attrs[:profile] = current_user.profile.merge attrs[:profile]
    end
  end

end
