class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority, default: "medium", null: false
      t.string :status, default: "pending", null: false
      t.date :due_date
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
