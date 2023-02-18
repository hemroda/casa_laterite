class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
