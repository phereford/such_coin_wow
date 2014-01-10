class SyncTransactionJob < Struct.new(:coin)
  def perform
    sync = SyncTransaction.new(coin)
    sync.update_coin
  end

  def error
    # TODO Error logging
  end

  def failure
    # TODO FAilure logging
  end
end
