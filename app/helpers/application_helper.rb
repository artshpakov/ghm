module ApplicationHelper
  
  def avatar type, options={}
    size = case type.to_sym
    when :profile then '160x160^'
    end

    content_tag :div, nil,
      style: "background-image: url(#{ current_user.avatar.thumb(size).url });#{options[:style]}",
      class: "avatar-#{type} #{options[:class]}"
  end

end
