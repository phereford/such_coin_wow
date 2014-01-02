require 'spec_helper'

describe Transaction, 'validations' do
  it { should validate_presence_of(:coin) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:transaction_id) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:category) }
  it { should validate_numericality_of(:amount) }
  it { should ensure_inclusion_of(:category).in_array(['send', 'receive']) }

  it 'validates uniqueness_of transaction_id scoped to category' do
    transaction = build(:transaction)
    transaction.save!(validate: false)
    should validate_uniqueness_of(:transaction_id).scoped_to(:category)
  end
end

describe Transaction, '#update_user_total' do
  it 'updates the user total when a new transaction is created' do
    user = create(:user)
    coin = create(:coin, user: user, mined: true)
    create(:transaction, coin: coin, amount: 100.555)

    expect(user.total_coins[coin.ticker]).to eql 100.555
  end
end
