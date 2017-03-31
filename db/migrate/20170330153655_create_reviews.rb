class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :text
      t.belongs_to :user, :movie
      t.timestamps
    end
  end
end
