require 'spec_helper'

describe Exchange::BterSync, 'new', vcr: true do
  before(:each) do
    @coin = build_stubbed(:coin, ticker: 'DOGE')
    set_klass(@coin)
    @coin.ticker.constantize.stub(:bter).and_return({'CNY' => 'doge_cny', 'LTC' => 'doge_ltc', 'BTC' => 'doge_btc'})
  end

  it 'updates the exchange rates for the coin' do
    expect{
      Exchange::BterSync.new(@coin)
    }.to change{@coin.exchange_rates.size}.by(3)
  end
end
