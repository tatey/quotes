class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :quote_id
      t.integer :vote_type
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
