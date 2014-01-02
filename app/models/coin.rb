class Coin < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  after_commit :set_initial_total_coin_value, if: :persisted?

  validates :name, presence: true, uniqueness: true
  validates :ticker, presence: true, uniqueness: true
  validates :user, presence: true

  def self.being_mined
    where(mined: true)
  end

  def daily_sum
    transactions
      .select('amount, date(occurred_at) as occurred_at')
      .group('date(occurred_at)')
      .sum(:amount)
  end

  def highcharts_array
    array = []
    daily_sum.sort.each do |key, value|
      array << [key.to_time.to_i*1000, value]
    end
    
    array
  end

  private
  def set_initial_total_coin_value
    if mined && user.total_coins[ticker].nil?
      user.total_coins_will_change!
      user.total_coins[ticker] = 0
      user.save!
    end
  end
end
