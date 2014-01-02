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
end