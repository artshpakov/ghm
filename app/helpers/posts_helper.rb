module PostsHelper

  def sanitize html
    Sanitize.fragment(html, Sanitize::Config::RELAXED).html_safe
  end

  def truncate text, length
    if text.length > length
      words = text.split(' ')
      text = ''
      words.each do |word|
        return text+'...' if text.length >= length
        text << ' '+word
      end
    end || text
  end

end
