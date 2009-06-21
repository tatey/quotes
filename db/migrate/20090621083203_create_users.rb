class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
    
    add_index :users, :email
    add_index :users, :persistence_token
  end

  def self.down
    drop_table :users
  end
end
