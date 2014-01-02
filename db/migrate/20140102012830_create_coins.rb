class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.string :ticker, null: false, length: 6
      t.hstore :cryptsy_market_ids, default: '', null: false
      t.boolean :mined, default: false
      t.hstore :trade_history, default: '', null: false
      t.datetime :last_synced_at

      t.timestamps
    end

    execute 'CREATE INDEX coin_cryptsy_ids ON coins USING GIN(cryptsy_market_ids)'
    execute 'CREATE INDEX coin_trade_history ON coins USING GIN(trade_history)'
    add_index :coins, :user_id
    add_index :coins, :ticker, unique: true
    add_index :coins, :name, unique: true
  end
end
