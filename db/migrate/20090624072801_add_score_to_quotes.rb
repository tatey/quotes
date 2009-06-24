class AddScoreToQuotes < ActiveRecord::Migration
  def self.up
    add_column :quotes, :score, :integer, :default => 0
  end

  def self.down
    remove_column :quotes, :score
  end
end
