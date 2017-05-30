class RenamePosterPathToCasts < ActiveRecord::Migration[5.0]
  def change
    rename_column :casts,:poster_path, :profile_path
  end
end
