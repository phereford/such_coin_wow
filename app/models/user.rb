class User < ActiveRecord::Base
  has_many :coins
  has_many :transactions, through: :coins
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable
end
