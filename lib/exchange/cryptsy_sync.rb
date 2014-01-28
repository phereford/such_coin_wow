module Exchange
  class CryptsySync < Base
    require 'cryptsy/api'

    private
    def update_markets
      @coin_klass.cryptsy.each do |market, id|
        update_exchange_rate(market, id)
      end
    end

    def update_exchange_rate(market, id)
      data = Cryptsy::API::Client.new.marketdata(id)['return']['markets'][@coin.ticker]

      @coin.exchange_rates.new(
        exchange: 'cryptsy',
        market_id: id,
        market: market,
        occurred_at: data['lasttradetime'],
        rate: data['lasttradeprice']
      )
    end
  end
end
