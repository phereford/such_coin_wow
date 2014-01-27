class SyncTransaction
  include Retryable

  def initialize(coin)
    @coin = coin
    @coin_klass = coin.ticker.constantize

    sync(@coin.transactions.blank? ? 10000 : 100)
    @coin.last_synced_at = Time.now
    @coin.save
  end

  private
  def sync(limit)
    client = Bitcoin::Client.new(@coin_klass.user, @coin_klass.password, host: '127.0.0.1', port: @coin_klass.port)
    client.listtransactions('*', limit).each do |transaction|
      transaction = Transaction.new(
        coin: @coin,
        address: transaction['address'],
        account: transaction['account'],
        transaction_id: transaction['txid'],
        amount: transaction['amount'],
        category: transaction['category'],
        confirmations: transaction['confirmations'],
        block_hash: transaction['blockhash'],
        block_index: transaction['blockindex'],
        occurred_at: Time.at(transaction['time'])
      )

      transaction.valid? ? transaction.save : nil
    end
  end
end
