class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  has_many :coins
  has_many :transactions, through: :coins
  devise :database_authenticatable, :recoverable, :rememberable,
    :trackable, :validatable

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def remember_me
    true
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
