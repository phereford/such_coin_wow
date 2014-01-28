require 'spec_helper'

describe ExchangeRate, 'relationships' do
  it { should belong_to(:coin) }
end

describe ExchangeRate, 'validations' do
  it { should validate_presence_of(:exchange) }
  it { should validate_presence_of(:occurred_at) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:market) }
  it { should validate_presence_of(:market_id) }
  it { should validate_numericality_of(:rate) }
  it { should validate_uniqueness_of(:exchange).scoped_to([:occurred_at, :coin_id]) }
  it { should ensure_inclusion_of(:exchange).in_array(ExchangeRate::EXCHANGES) }
end
