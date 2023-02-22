class CreateSharedDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_discussions do |t|
      t.belongs_to :account
      t.belongs_to :discussion
      t.references :removed_by, polymorphic: true, index: true
      t.references :invited_by, polymorphic: true, index: true

      t.timestamps
    end
  end
end
