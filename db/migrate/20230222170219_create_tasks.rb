class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :milestone, index: true, foreign_key: true, null: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :completed_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
