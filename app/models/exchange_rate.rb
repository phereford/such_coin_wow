class ExchangeRate < ActiveRecord::Base
  EXCHANGES = [ 'bter', 'vircurex', 'cryptsy' ]
  belongs_to :coin

  validate :market, presence: true, uniqueness: { scope: [:occurred_at, :coin] }, inclusion: { in: EXCHANGES }
  validate :market_id, presence: true
  validate :market_type, presence: true
  validate :occurred_at, presence: true
  validate :rate, presence: true, numericality: true
end
