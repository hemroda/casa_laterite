class RemoveReviewedAtFromCampaigns < ActiveRecord::Migration[7.0]
  def change
    remove_column :campaigns, :reviewed_at, :datetime

  end
end
