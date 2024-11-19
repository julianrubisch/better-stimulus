class AddAccessTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :access_token, :text
    add_column :users, :refresh_token, :text
    add_column :users, :patreon_id, :integer
  end
end
