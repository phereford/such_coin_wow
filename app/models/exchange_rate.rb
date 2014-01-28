class ExchangeRate < ActiveRecord::Base
  EXCHANGES = [ 'bter', 'vircurex', 'cryptsy' ]
  belongs_to :coin

  validates :exchange, presence: true, uniqueness: { scope: [:occurred_at, :coin_id] }, inclusion: { in: EXCHANGES }
  validates :market_id, presence: true
  validates :market, presence: true
  validates :occurred_at, presence: true
  validates :rate, presence: true, numericality: true
end
