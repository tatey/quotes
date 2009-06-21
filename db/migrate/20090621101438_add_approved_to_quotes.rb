class AddApprovedToQuotes < ActiveRecord::Migration
  def self.up
    add_column :quotes, :approved, :boolean, :default => false
    
    add_index :quotes, :approved
  end

  def self.down
    remove_column :quotes, :approved, :boolean
    
    remove_index :quotes, :approved
  end
end
