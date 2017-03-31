class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.belongs_to :user, :movie
      t.timestamps
    end
  end
end
