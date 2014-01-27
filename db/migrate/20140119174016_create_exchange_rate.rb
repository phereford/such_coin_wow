class CreateExchangeRate < ActiveRecord::Migration
  def change
    create_table(:exchange_rates) do |t|
      t.belongs_to :coin
      t.string :market
      t.string :market_id
      t.string :market_type
      t.datetime :occurred_at
      t.float :rate
    end

    add_index :exchange_rates, :coin_id
  end
end
