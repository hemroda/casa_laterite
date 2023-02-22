class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.belongs_to :deck, index: true, foreign_key: true, null: false
      t.integer :proficiency_level, default: 0
      t.datetime :reviewed_at

      t.timestamps
    end
  end
end
