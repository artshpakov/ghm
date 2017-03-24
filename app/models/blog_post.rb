class BlogPost < Post

  def blog
    Blog.find(post.user.slug)
  end

end
