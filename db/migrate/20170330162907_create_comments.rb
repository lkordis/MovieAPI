class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, :id => false do |t|
      t.text :text
      t.references :user, index: true, foreign_key: { to_table: :users }
      t.references :review, index: true, foreign_key: { to_table: :reviews }
      t.timestamps
    end
  end
end
