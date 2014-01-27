require 'spec_helper'

describe Coin, 'relationships' do
  it { should have_many(:transactions) }
  it { should have_many(:exchange_rates) }
  it { should belong_to(:user) }
end

describe Coin, 'validations' do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ticker) }
  it { should validate_presence_of(:user) }

  it 'validates uniqueness_of name' do
    create_user_and_coin
    should validate_uniqueness_of(:name)
  end

  it 'validates uniqueness_of name' do
    create_user_and_coin
    should validate_uniqueness_of(:ticker)
  end
end

describe Coin, '.being_mined' do
  it 'returns an array of coins being mined' do
    coin = create(:coin, mined: true)

    expect(Coin.being_mined).to include coin
  end

  it 'returns nothing for non mined coins' do
    coin = create(:coin, mined: false)

    expect(Coin.being_mined).to_not include coin
  end
end

describe Coin, '#daily_sum' do
  it 'returns a hash where the key is a date and the value is the amount sum' do
    coin = create_coin_with_transactions
    expect(coin.daily_sum).to include
    {
      Date.yesterday.to_s => 500,
      Date.today.to_s => 300
    }
  end
end

describe Coin, '#highcharts_array' do
  it 'returns a nested array of posix timestamp and amounts' do
    coin = create_coin_with_transactions
    expect(coin.highcharts_array).to include
    [
      [Date.yesterday.to_time.to_i*1000, 500],
      [Date.today.to_time.to_i*1000, 300]
    ]
  end
end

describe Coin, '#set_initial_total_coin_value' do
  it 'sets the default value of total_coins for a mined coin to 0' do
    coin = create(:coin, mined: true)
    expect(coin.user.total_coins[coin.ticker]).to eql 0
  end

  it 'does not set the default value of totals_coins for a non mined coin' do
    coin = create(:coin, mined: false)
    expect(coin.user.total_coins[coin.ticker]).to be nil
  end

  it 'does not set the default value of total_coins for a mined already set coin' do
    coin = create(:coin, mined: true)
    coin.user.total_coins_will_change!
    coin.user.total_coins[coin.ticker] = 100
    coin.user.save!

    expect(Coin.where(ticker: coin.ticker).first.user.total_coins[coin.ticker]).to eql '100'
  end
end
