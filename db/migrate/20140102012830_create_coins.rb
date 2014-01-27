class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.string :ticker, null: false, length: 6
      t.boolean :mined, default: false
      t.datetime :last_synced_at

      t.timestamps
    end

    add_index :coins, :user_id
    add_index :coins, :ticker, unique: true
    add_index :coins, :name, unique: true
    add_index :coins, :mined
  end
end
