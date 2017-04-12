module ImageManager

  def self.fetch img, size=nil
    image = Dragonfly.app.fetch(img)
    image = image.thumb("#{ size }x#{ size }^") if size
    image.url
  end

  def self.store img
    Dragonfly.app.store(img)
  end

  def self.download url
    Dragonfly.app.fetch_url(url)
  end

  def self.initial_avatar str
    Dragonfly.app.generate(:initial_avatar, str, background_color: "%06x" % (rand * 0xffffff))
  end

end
