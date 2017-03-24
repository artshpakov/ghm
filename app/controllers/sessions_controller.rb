class SessionsController < ApplicationController

  def create
    if login(params[:email], params[:password])
      redirect_to root_path
    else
      redirect_to signin_path, flash: { error: 'Invalid credentials' }
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end

end
