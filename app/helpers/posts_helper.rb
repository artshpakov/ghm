module PostsHelper

  def sanitize html
    Sanitize.fragment(html, Sanitize::Config::RELAXED).html_safe
  end

  def truncate text, length
    text && text.length > length ? "#{ text[0..length] }..." : text
  end

end
