class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :noticeable, polymorphic: true, index: true, null: false
      t.references :sent_by, polymorphic: true, index: true
      t.integer :notification_type

      t.timestamps
    end
  end
end
