module Exchange
  class BterSync < Base
    require 'bter'

    private
    def update_markets
      if @coin_klass.bter
        @coin_klass.bter.each do |market, id|
          update_exchange_rate(market, id)
        end
      end
    end

    def update_exchange_rate(market, id)
      data = Bter::Public.new.ticker(id)

      @coin.exchange_rates.new(
        exchange: 'bter',
        market_id: id,
        market: market,
        occurred_at: Time.now,
        rate: data[:last]
      )
    end
  end
end
