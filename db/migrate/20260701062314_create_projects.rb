class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.string :status, default: "active", null: false
      t.timestamps
    end
  end
end
