class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :manageable, polymorphic: true, index: true, null: false
      t.references :assigned_by, polymorphic: true, index: true
      t.references :unassigned_by, polymorphic: true, index: true
      t.boolean :lead_manager, default:false

      t.timestamps
    end
  end
end
