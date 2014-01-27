class SyncCoinJob < Struct.new(:coin)
  def perform
    SyncTransaction.new(coin)
    Exchange::BterSync.new(coin)
    Exchange::CryptsySync.new(coin)
    Exchange::VircurexSync.new(coin)
  end

  def error
    # TODO Error logging
  end

  def failure
    # TODO FAilure logging
  end
end
