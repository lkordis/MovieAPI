class RenameLastNameInCast < ActiveRecord::Migration[5.0]
  def change
    rename_column :casts, :lastName, :last_name
  end
end
