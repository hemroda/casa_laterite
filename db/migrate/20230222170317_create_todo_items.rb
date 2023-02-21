class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.belongs_to :task, index: true, foreign_key: true, null: true
      t.string :title, null: false
      t.boolean :completed, default: false
      t.datetime :completed_at, default: nil

      t.timestamps
    end
  end
end
