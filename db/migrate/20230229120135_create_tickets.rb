class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :ticketable, polymorphic: true, index: true, null: false
      t.integer :ticket_type, null: false
      t.string :name, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :completed_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
