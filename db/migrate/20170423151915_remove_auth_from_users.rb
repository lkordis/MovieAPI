class RemoveAuthFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :auth_token
  end
end
