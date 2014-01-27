class CoinSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name, :ticker, :last_synced_at

  has_many :transactions, key: :transaction_ids, root: :transactions
  has_many :exchange_rates, key: :exchange_rate_ids, root: :exchange_rates
end
