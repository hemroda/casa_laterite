class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :projectable, polymorphic: true, index: true, null: false
      t.belongs_to :project_type, index: true, foreign_key: true, null: false
      t.string :name
      t.text :description
      t.integer :status, default: 0
      t.integer :visibility_type, default: 0
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :completed_at
      t.boolean :tracked, default: false

      t.timestamps
    end
  end
end
