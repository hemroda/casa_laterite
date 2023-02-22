class CreateDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :decks do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: true
      t.string :name, null: false
      t.integer :status, default: 0
      t.integer :access_type, default: 0
      t.datetime :reviewed_at

      t.timestamps
    end
  end
end
