class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.float :amount, null: false, default: 0.00
      t.string :name, null: false
      t.text :message
      t.integer :status, default: 0
      t.datetime :due_date
      t.references :payable, polymorphic: true, index: true, null: false
      t.references :created_by, polymorphic: true, index: true, null: false
      t.references :canceled_by, polymorphic: true, index: true
      t.references :validated_by, polymorphic: true, index: true

      t.timestamps
    end
  end
end
