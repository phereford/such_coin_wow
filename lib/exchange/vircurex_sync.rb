module Exchange
  class VircurexSync < Base
    require 'vircurex'

    private
    def update_markets
      if @coin_klass.vircurex
        @coin_klass.vircurex.each do |market, id|
          update_exchange_rate(market, id)
        end
      end
    end

    def update_exchange_rate(market, id)
      data = Vircurex::API.new('such_coin_wow').get_last_trade({
        base: id,
        alt: market
      })

      @coin.exchange_rates.new(
        exchange: 'vircurex',
        marked_id: id,
        market: market,
        occurred_at: Time.now,
        rate: data['value']
      )
    end
  end
end
