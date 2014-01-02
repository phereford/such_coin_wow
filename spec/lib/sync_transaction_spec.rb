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
end

describe SyncTransaction, '#sync' do
  it 'connects to the JSON-RPC server' do
  end

  it 'gets a list of transactions' do
  end

  it 'persists the transaction on validation' do
  end

  it 'does not save the transaction' do
  end
end
