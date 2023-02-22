class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.belongs_to :question, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
