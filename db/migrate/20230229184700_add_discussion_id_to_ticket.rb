class AddDiscussionIdToTicket < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :discussion, on_delete: :cascade
  end
end
