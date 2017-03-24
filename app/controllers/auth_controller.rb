class AuthController < ApplicationController

  def change_password
    if @user = User.find_by_email(params[:email])
      @user.generate_password && @user.save
      redirect_to signin_path, notice: t('auth.signin.sent', email: params[:email])
    else
      redirect_to signin_path, flash: { error: t('auth.signin.notfound') }
    end
  end

  def callback
    data = env["omniauth.auth"].slice :provider, :uid, :info, :extra
    if identity = Identity.find_by(provider: data[:provider], uid: data[:uid])
      auto_login identity.user
      redirect_to root_path
    else
      @identity = Identity.from_omniauth(data)
    end
  end

  def commit
    if user = User.find_by(email: params[:user_attributes][:email])
      identity = Identity.new identity_params
      user.identities << identity
      user.update profile: user.profile.reverse_merge(identity_params[:user_attributes][:profile])
    else
      identity = Identity.new identity_params
      identity.user.generate_password
      identity.save
    end

    if identity.persisted?
      auto_login identity.user
    else
      flash[:error] = { error: identity.errors } unless identity.persisted?
    end
    redirect_to root_path
  end


  private

  def identity_params
    @attrs ||= params.permit(:provider, :uid, user_attributes: [:email, :profile]).to_h.tap do |hash|
      hash[:user_attributes].merge! profile: JSON.parse(params.delete :profile)
    end
  end

end
