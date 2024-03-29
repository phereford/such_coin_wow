class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :authentication_token, null: false
      t.hstore :total_coins, default: '', null: false
      t.timestamps
    end

    execute 'CREATE INDEX user_total_coins ON users USING GIN(total_coins)'
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
