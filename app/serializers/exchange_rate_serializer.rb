class ExchangeRateSerializer < ActiveModel::Serializer
  attributes :id, :market, :exchange, :occurred_at, :rate

  def market
    object.exchange.capitalize
  end
end
