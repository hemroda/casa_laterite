class AddDiscardedAtToContributions < ActiveRecord::Migration[7.0]
  def change
    add_column :contributions, :discarded_at, :datetime
    add_index :contributions, :discarded_at
  end
end
