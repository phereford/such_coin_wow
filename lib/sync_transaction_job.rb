class SyncTransactionJob < Struct.new(:coin)
  def perform
    SyncTransaction.new(coin)
  end

  def error
    # TODO Error logging
  end

  def failure
    # TODO FAilure logging
  end
end
