class CreateCastRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :cast_roles do |t|
      t.string :role

      t.timestamps
    end
  end
end
