class AuthMailer < ApplicationMailer

  default template_path: 'mail/auth'

  def signup user
    @user = user
    mail to: user.email, subject: "Welcome to GMH"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Your password has been reset"
  end

end
