class RemoveRoleNameFromCredits < ActiveRecord::Migration[5.0]
  def change
    remove_column :credits, :roleName
  end
end
