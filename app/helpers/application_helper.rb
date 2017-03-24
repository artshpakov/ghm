module ApplicationHelper

  def avatar user, type, options={}
    size = case type.to_sym
    when :profile then '160x160^'
    when :inline then '80x80^'
    when :tiny then '40x40^'
    when :personal then '100x100^'
    end

    content_tag :div, nil,
      style: "background-image: url(#{ user.avatar.thumb(size).url });#{options[:style]}",
      class: "avatar avatar-#{type} #{options[:class]}"
  end

end
