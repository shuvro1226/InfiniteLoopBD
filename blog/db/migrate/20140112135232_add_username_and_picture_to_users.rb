class AddUsernameAndPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :unique => true, :null => false, :default => ""
    add_column :users, :picture, :string
  end
end
