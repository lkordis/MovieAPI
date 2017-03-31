class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits, :id => false do |t|
      t.references :movie, index: true, foreign_key: { to_table: :movies }
      t.references :cast, index: true, foreign_key: { to_table: :casts }
      t.references :cast_role, index: true, foreign_key: { to_table: :cast_roles }
      t.string :roleName
      t.timestamps
    end
  end
end
