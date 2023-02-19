class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.belongs_to :property_type, index: true, foreign_key: true, null: false
      t.references :building, foreign_key: { to_table: :properties }
      t.string :name, null: false
      t.text :description
      t.integer :rooms
      t.integer :bathrooms
      t.datetime :year_built
      t.integer :square_feet

      t.timestamps
    end
  end
end
