class AddIndexToVoteTypeInVotes < ActiveRecord::Migration
  def self.up
    add_index :votes, :vote_type
  end

  def self.down
    remove_index :votes, :vote_type
  end
end
