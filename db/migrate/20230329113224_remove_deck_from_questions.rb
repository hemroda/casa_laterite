class RemoveDeckFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :questions, :deck, index: true, null: false
  end
end
