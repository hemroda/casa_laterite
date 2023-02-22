class CreateContributions < ActiveRecord::Migration[7.0]
  def change
    create_table :contributions do |t|
      t.string :name, null: false
      t.float :amount, null: false, default: 0.00
      t.text :description
      t.integer :contribution_type
      t.belongs_to :account, index: true, foreign_key: true
      t.references :contributable, polymorphic: true, index: true, null: false
      t.references :validated_by, polymorphic: true, index: true
      t.references :cancelled_by, polymorphic: true, index: true

      t.timestamps
    end
  end
end
