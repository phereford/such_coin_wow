class CoinsSerializer < ActiveModel::Serializer
  attributes :id, :name, :ticker, :mined, :last_synced_at
end
