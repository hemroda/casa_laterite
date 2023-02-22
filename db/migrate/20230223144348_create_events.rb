class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :location
      t.integer :event_type, default: 0
      t.string :color
      t.boolean :shared

      t.timestamps
    end
  end
end
