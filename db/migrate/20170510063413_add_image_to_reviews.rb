class AddImageToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :image_url, :string
  end
end
