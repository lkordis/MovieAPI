class RemoveCastRoleFromCredits < ActiveRecord::Migration[5.0]
  def change
    drop_table :credits
    create_table :credits, :id => false do |t|
      t.references :movie, index: true, foreign_key: { to_table: :movies }
      t.references :cast, index: true, foreign_key: { to_table: :casts }
      t.string :roleName
      t.timestamps
    end
  end
end
