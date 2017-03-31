class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships, :id => false do |t|
      t.references :userId1, index: true, foreign_key: { to_table: :users }
      t.references :userId2, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
