class AddCampaignReferenceToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :campaign, null: false, foreign_key: true
  end
end
