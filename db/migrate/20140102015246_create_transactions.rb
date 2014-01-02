class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :coin
      t.string :account
      t.string :address
      t.string :category
      t.float :amount
      t.integer :confirmations
      t.string :block_hash
      t.string :block_index
      t.string :transaction_id
      t.datetime :occurred_at

      t.timestamps
    end

    add_index :transactions, :coin_id
  end
end
