class CreateOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :ownerships do |t|
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :property, index: true, foreign_key: true
      t.references :deallocated_by, polymorphic: true, index: true
      t.references :allocated_by, polymorphic: true, index: true
      t.integer :old_owner_id

      t.timestamps
    end
  end
end
