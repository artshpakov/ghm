class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :polymorphic_post_path


  rescue_from CanCan::AccessDenied do |exception|
    render template: "_errors/forbidden", status: :forbidden
  end

  def check_authentication
    redirect_to signin_path unless logged_in?
  end


  def polymorphic_post_path post
    case post.class.name
    when 'Article' then article_path(post)
    when 'BlogPost' then blog_post_path(post.user.slug, post)
    end
  end

end
