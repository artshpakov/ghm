module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, uniqueness: true

    before_create do
      original = try(:title) || try(:name) || slug_source
      self.slug = original.to_slug.normalize(transliterations: :russian).to_s
      # TODO check for collisions
    end
  end

end
