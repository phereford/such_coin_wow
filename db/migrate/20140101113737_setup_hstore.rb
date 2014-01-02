class SetupHstore < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION hstore"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
