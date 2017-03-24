class User < ApplicationRecord

  include Sluggable

  module Roles
    ADMIN = :admin
    EDITOR = :editor

    def self.to_a
      [ADMIN, EDITOR]
    end
  end


  authenticates_with_sorcery!

  dragonfly_accessor :avatar do
    after_assign { |img| img.thumb!('200x200^') rescue nil }
  end

  has_many :identities, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :blog_posts, dependent: :destroy
  has_and_belongs_to_many :followers, class_name: 'User', join_table: 'followings', foreign_key: 'object_id', association_foreign_key: 'follower_id'
  has_and_belongs_to_many :follows, class_name: 'User', join_table: 'followings', foreign_key: 'follower_id', association_foreign_key: 'object_id'

  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password, confirmation: true, if: :new_record?
  validates :password_confirmation, presence: true, if: :new_record?

  before_create :generate_password, :generate_avatar
  after_create :notify_on_create
  after_update :notify_on_update


  def name
    "#{ profile['firstname'] } #{ profile['lastname'] }".strip.presence || email
  end


  def grant! role
    update(roles: roles.push(role)) if role.in?(Roles.to_a) && !has_role?(role)
  end

  def has_role? role
    roles.include? role.to_s
  end


  def set_password password, confirmation=nil
    self.password = password
    self.password_confirmation = confirmation
    encrypt_password
    password
  end

  def generate_password
    unless password.present?
      password = SecureRandom.hex(5)
      set_password password, password
    end
  end


  def blog
    Blog.find(slug)
  end


  protected

  def generate_avatar
    self.avatar = ImageManager.initial_avatar(name) unless avatar.present?
  end

  def notify_on_create
    AuthMailer.signup(self).deliver_now
  end

  def notify_on_update
    AuthMailer.password_reset(self).deliver_now if crypted_password_changed?
  end

end
