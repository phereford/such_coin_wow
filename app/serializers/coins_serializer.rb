class CoinsSerializer < ActiveModel::Serializer
  attributes :id, :name, :ticker, :last_synced_at
end
