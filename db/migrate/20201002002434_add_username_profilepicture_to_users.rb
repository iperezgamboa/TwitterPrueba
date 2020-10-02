class AddUsernameProfilepictureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :profile_picture, :string
  end
end
