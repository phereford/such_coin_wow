class CreateExchangeRate < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.belongs_to :coin
      t.string :exchange
      t.string :market_id
      t.string :market
      t.float :rate
      t.datetime :occurred_at

      t.timestamps
    end

    add_index :exchange_rates, :coin_id
  end
end
