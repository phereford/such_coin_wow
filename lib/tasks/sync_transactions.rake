namespace :sync do

  desc 'Sync transactions for mined coins'
  task :transactions => :environment do
    require 'sync_transaction'
    Coin.being_mined.find_each do |coin|
      SyncTransaction.new(coin)
    end
  end
end
