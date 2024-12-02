class User < ApplicationRecord
  has_secure_password

  has_many :articles, dependent: :destroy

  attribute :role, :integer, default: 0

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  enum role: { user: 0, admin: 1, moderator: 2 }

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end

  def user?
    role == "user"
  end

  after_initialize :set_default_role, if: :new_record?

  normalizes :email, with: ->(email) { email.strip.downcase }
  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end
  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
