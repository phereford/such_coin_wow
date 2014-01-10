require 'spec_helper'

describe SyncTransaction, '.new', vcr: true do
  before(:each) do
    @coin = create(:coin)
    set_klass(@coin)
  end

  it 'assigns @coin' do
    sync = SyncTransaction.new(@coin)
    expect(sync.instance_variable_get(:@coin)).to eql @coin
  end

  it 'assigns @coin_klass' do
    sync = SyncTransaction.new(@coin)
    expect(sync.instance_variable_get(:@coin_klass)).to eql @coin.ticker.constantize
  end

  it 'syncs the coin object' do
    expect{SyncTransaction.new(@coin)}.to change{@coin.transactions.count}
  end
end
