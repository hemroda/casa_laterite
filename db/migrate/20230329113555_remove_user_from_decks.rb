class RemoveUserFromDecks < ActiveRecord::Migration[7.0]
  def change
    remove_reference :decks, :user, index: true
  end
end
