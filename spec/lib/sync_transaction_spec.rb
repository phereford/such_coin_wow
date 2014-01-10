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

describe SyncTransaction, '#update_coin', vcr: true do
  before(:each) do
    @coin = create(:coin)
    set_klass(@coin)
    @sync = SyncTransaction.new(@coin)
  end

  it 'updates the trade history' do
    binding.pry
    expect{
      @sync.update_coin
    }.to change{@coin.trade_history}
  end

  it 'changes the coin\'s last_synced_at timestamp' do
    expect{
      @sync.update_coin
    }.to change{@coin.last_synced_at}
  end

  it 'persists the changes to the coin' do
    expect(
      Coin.find(@coin.id).last_synced_at
    ).to eql @coin.last_synced_at
  end

  it 're-queues another sync job in 2 hours' do
    expect{
      @sync.update_coin
    }.to change{Delayed::Job.where(queue: @coin.ticker).first.run_at}
  end
end
