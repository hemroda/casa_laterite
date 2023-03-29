class RemoveProficiencyLevelFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :proficiency_level, :integer
  end
end
