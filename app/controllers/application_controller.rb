class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render template: "_errors/forbidden", status: :forbidden
  end
end
