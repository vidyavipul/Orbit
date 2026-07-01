class AddDefaultRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :role, from: nil, to: :employee
    change_column_null :users, :role, false, "employee"
  end
end
