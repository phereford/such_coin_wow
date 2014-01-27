class ExchangeRateSerializer < ActiveModel::Serializer
  attributes :id, :market, :market_type, :occurred_at, :rate

  def market
    object.market.capitalize
  end
end
