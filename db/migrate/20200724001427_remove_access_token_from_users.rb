class RemoveAccessTokenFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :access_token
    remove_column :users, :refresh_token
  end
end
