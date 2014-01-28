require 'spec_helper'

describe Exchange::VircurexSync, '.new', vcr: true do
  before(:each) do
    @coin = build_stubbed(:coin)
    set_klass(@coin)
    @coin.ticker.constantize.stub(:vircurex).and_return({'LTC' => 'doge_ltc', 'BTC' => 'doge_btc'})
  end

  it 'should update the exchange rate' do
    expect{
      Exchange::VircurexSync.new(@coin)
    }.to change{@coin.exchange_rates.size}.by(2)
  end
end
