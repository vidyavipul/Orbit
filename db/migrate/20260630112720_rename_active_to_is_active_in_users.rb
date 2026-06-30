class RenameActiveToIsActiveInUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :active, :is_active
  end
end
