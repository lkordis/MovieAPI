class AddPosterPathToCasts < ActiveRecord::Migration[5.0]
  def change
    add_column :casts, :poster_path, :string
  end
end
