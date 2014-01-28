require 'spec_helper'

describe Exchange::CryptsySync, '.new',  vcr: true do
  before(:each) do
    @coin = build_stubbed(:coin, ticker: 'DOGE')
    set_klass(@coin)
    @coin.ticker.constantize.stub(:cryptsy).and_return({'BTC' => 132, 'LTC' => 135})
  end

  it 'updates the exchange rates for the coin' do
    expect{
      Exchange::CryptsySync.new(@coin)
    }.to change{@coin.exchange_rates.size}.by(2)
  end
end
