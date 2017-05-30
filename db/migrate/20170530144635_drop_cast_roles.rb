class DropCastRoles < ActiveRecord::Migration[5.0]
  def change
    drop_table :cast_roles
  end
end
