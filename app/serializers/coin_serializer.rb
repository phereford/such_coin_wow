class CoinSerializer < ActiveModel::Serializer
  attributes :user, :transactions, :name, :ticker
end
