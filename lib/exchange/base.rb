module Exchange
  class Base
    include Retryable

    def initialize(coin)
      @coin = coin
      @coin_klass = coin.ticker.constantize

      update_markets
      check_and_queue
    end

    private
    def update_markets
    end

    def check_and_queue
      @coin.remove_jobs

      Delayed::Job.enqueue(
        SyncCoinJob.new(@coin),
        run_at: 2.hours.from_now,
        queue: @coin.ticker
      )
    end
  end
end
