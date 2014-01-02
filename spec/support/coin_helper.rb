module CoinHelper
  def create_user_and_coin
    user = create(:user)
    Coin.new(name: 'Doge', ticker: 'DOGEE', user: user).save!(validate: false)
  end

  def create_coin_with_transactions
    coin = create(:coin)
    create(:transaction, occurred_at: Date.yesterday, amount: 500, coin: coin)
    create(:transaction, occurred_at: Date.today, amount: 300, coin: coin)

    coin
  end
end
