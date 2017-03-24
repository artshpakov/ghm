class UsersController < ApplicationController

  def create
    @user = User.new user_params
    if @user.save
      @user.update avatar: ImageManager.initial_avatar(@user.name)
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path
    else
      redirect_to signup_path, flash: {error: @user.errors.messages}
    end
  end


  protected

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation).to_h
  end

end
