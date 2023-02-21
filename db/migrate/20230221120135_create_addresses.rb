class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string  :line_one
      t.string  :line_two
      t.string  :phone_number
      t.string  :city
      t.string  :zip_code
      t.string  :country
      t.text    :additional_information
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
