class Blog

  DEFAULT_LIMIT = 5

  def initialize user
    self.user = user
  end

  attr_accessor :user, :most_recent_post

  def to_param
    user.slug
  end


  def self.recent limit=DEFAULT_LIMIT
    ids = BlogPost.select("user_id, max(id) AS id").group("user_id").limit(limit).map &:id
    posts = BlogPost.where(id: ids).most_recent.includes(:user)
    posts.map do |post|
      blog = new post.user
      blog.most_recent_post = posts.find_by(user_id: blog.user.id)
      blog
    end
  end

  def self.trending limit=DEFAULT_LIMIT
    []
  end

  def self.promoted limit=DEFAULT_LIMIT
    []
  end


  def self.find slug
    new User.find_by!(slug: slug)
  end

  def posts
    BlogPost.where(user_id: user.id)
  end


  # TODO eliminate N+1 queries
  def posts_count
    posts.count
  end

  def followers_count
    followers.count
  end

  def likes_count
    posts.pluck(:likes).flatten.count
  end


  delegate :followers, to: :user

  def is_followed_by? follower
    user.followers.include? follower
  end

end
