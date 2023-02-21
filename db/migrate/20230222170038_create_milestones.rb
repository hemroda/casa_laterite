class CreateMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :milestones do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
