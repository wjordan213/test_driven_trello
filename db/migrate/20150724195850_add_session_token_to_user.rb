class AddSessionTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string

    add_index :users, :session_token, unique: true
    add_index :users, :username, unique: true
  end
end
