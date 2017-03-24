class Post < ApplicationRecord

  self.inheritance_column = :kind

  include Sluggable

  paginates_per 25

  belongs_to :user

  scope :most_recent, -> { order created_at: :desc }
  scope :by_tag, ->(tag) { where "'#{tag}' = ANY(tags)" }

  def to_param
    slug
  end

  def liked_by? user
    user.kind_of?(User) && likes.include?(user.id)
  end

  def comments
    []
  end

end
