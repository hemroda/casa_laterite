class RenameDeckToCampaign < ActiveRecord::Migration[7.0]
  def change
    rename_table :decks, :campaigns
  end
end
