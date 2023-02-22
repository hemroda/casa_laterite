class AddDiscardedAtToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :discarded_at, :datetime
    add_index :payments, :discarded_at
  end
end
