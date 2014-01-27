FactoryGirl.define do
  sequence(:email) { |n| "asd#{n}@asd.com" }
  sequence(:ticker) { |n| "DG#{n}" }
  sequence(:name) { |n| "DogeCoi#{n}" }
  sequence(:transaction_id) { SecureRandom.urlsafe_base64(64) }

  factory :user do
    email
    password 'passw0rd'
    password_confirmation 'passw0rd'
  end

  factory :coin do
    user
    name
    ticker
    cryptsy_market_ids { { 'BTC' => 132 } }

    trait :invalid do
      name nil
    end
  end

  factory :transaction do
    coin
    address 'Cryptsy'
    transaction_id
    amount 100.25
    category 'send'
    occurred_at { Date.today }
  end

  factory :exchange_rate do
    coin
    market 'cryptsy'
    market_id '132'
    market_type 'BTC'
    occurred_at { Time.now }
    rate 1.09
  end
end
