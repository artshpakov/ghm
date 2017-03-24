module PostsHelper

  def sanitize html
    Sanitize.fragment(html, Sanitize::Config::RELAXED).html_safe
  end

  def truncate text, length
    text && text.length > length ? "#{ text[0..length] }..." : text
  end

  def like_link post
    if can? :like, post
      link_to('javascript:;', role: 'like', class: "#{ 'liked' if post.liked_by?(current_user) }", data: { url: like_post_path(post), count: post.likes.count }) do
        fa_icon(post.liked_by?(current_user) ? 'heart' : 'heart-o') + " " + content_tag(:span, post.likes.count, role: 'counter')
      end
    else
      fa_icon('heart-o') + " #{ post.likes.count }"
    end
  end

end
