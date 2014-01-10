class SyncTransaction
  include Retryable
  require 'cryptsy/api'

  def initialize(coin)
    @coin = coin
    @coin_klass = coin.ticker.constantize

    sync(@coin.transactions.blank? ? 10000 : 100)
  end

  def update_coin_object
    update_trade_history
    @coin.last_synced_at = Time.now
    @coin.save

    check_and_queue
  end

  private
  def check_trade_history(market_name)
    if @coin.trade_history[market_name].nil?
      @coin.trade_history[market_name] = {}
    end
  end

  def update_trade_history
    @coin.trade_history_will_change!
    @coin.cryptsy_market_ids.each do |market_name, market_id|
      check_trade_history(market_name)
      @coin.trade_history[market_name].merge!(last_traded_amount(market_id))
    end
  end

  def last_traded_amount(market_id)
    data = Cryptsy::API::Client.new.marketdata(market_id)

    {
      data['return']['markets'][@coin.ticker]['lasttradetime'] => data['return']['markets'][@coin.ticker]['lasttradeprice']
    }
  end

  def sync(limit)
    client = Bitcoin::Client.new(@coin_klass.user, @coin_klass.password, host: '127.0.0.1', port: @coin_klass.port)
    client.listtransactions('*', limit).each do |transaction|
      transaction = @coin.transactions.new(
        address: transaction['address'],
        account: transaction['account'],
        transaction_id: transaction['txid'],
        amount: transaction_amount(transaction),
        category: transaction['category'],
        confirmations: transaction['confirmations'],
        block_hash: transaction['blockhash'],
        block_index: transaction['blockindex'],
        occurred_at: Time.at(transaction['time'])
      )

      transaction.valid? ? transaction.save : nil
    end
  end

  def check_and_queue
    if job = Delayed::Job.where(queue: @coin.ticker).first
      job.destroy
    end

    Delayed::Job.enqueue(
      SyncTransactionJob.new(@coin),
      run_at: 2.hours.from_now,
      queue: @coin.ticker
    )
  end

  def transaction_amount(transaction)
    if transaction['category'] == 'receive'
      transaction['amount']
    else
      transaction['amount'] * -1
    end
  end
end
