class PostsController < ApplicationController

  load_and_authorize_resource find_by: :slug


  def new
    entity = params[:kind].singularize.camelcase.constantize
    @post = entity.new(user: current_user)
  end

  def create
    @post = current_user.posts.create post_params
    redirect_to polymorphic_post_path(@post)
  end

  def update
    @post.update post_params
    redirect_to polymorphic_post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end


  def like
    @post.likes << current_user.id
    @post.save
    render nothing: true, status: :no_content
  end

  def dislike
    @post.likes_will_change!
    @post.update likes: (@post.likes - [current_user.id])
    render nothing: true, status: :no_content
  end


  private

  def post_params
    params.require(:post).permit(:kind, :title, :text, tags: [])
  end

end
