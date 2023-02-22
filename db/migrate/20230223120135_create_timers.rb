class CreateTimers < ActiveRecord::Migration[7.0]
  def change
    create_table :timers do |t|
      t.belongs_to :task, index: true, foreign_key: true, null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
