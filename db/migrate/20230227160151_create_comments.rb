class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true, null: false
      t.references :submitted_by, polymorphic: true, index: true

      t.timestamps
    end
  end
end
