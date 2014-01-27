class Transaction < ActiveRecord::Base
  belongs_to :coin
  delegate :name, :user, to: :coin, prefix: true
  after_create :update_user_total

  validates :coin, presence: true
  validates :address, presence: true
  validates :transaction_id, presence: true, uniqueness: { scope: :category }
  validates :amount, presence: true, numericality: true
  validates :category, presence: true, inclusion: { in: %w(receive send) }

  private
  def update_user_total
    coin_user.total_coins_will_change!
    current_total =  coin_user.total_coins[coin.ticker].to_f
    real_amount = category == 'send' ? (amount * -1) : amount
    coin_user.total_coins[coin.ticker] = current_total + real_amount
    coin_user.save!
  end
end
