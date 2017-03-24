class User < ActiveRecord::Base

  authenticates_with_sorcery!

  module Roles
    ADMIN = :admin
  end

  has_many :identities, dependent: :destroy

  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password, confirmation: true, if: :new_record?
  validates :password_confirmation, presence: true, if: :new_record?

  before_create :generate_password
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


  protected

  def notify_on_create
    AuthMailer.signup(self).deliver_now
  end

  def notify_on_update
    AuthMailer.password_reset(self).deliver_now if crypted_password_changed?
  end

end
