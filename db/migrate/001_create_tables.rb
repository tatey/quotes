class CreateTables < Sequel::Migration
  def up
    create_table :quotes do
      primary_key :id
      column :text, :text
      column :votes_count, :integer, :default => 0
      column :created_at, :datetime
    end
    
    create_table :votes do
      primary_key :id
      column :vote_type, :integer
      column :quote_id, :integer
      column :created_at, :datetime
    end  
  end
  
  def down
    drop_table :quotes, :votes
  end
end
