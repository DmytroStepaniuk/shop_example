class RemoveUsersFromLineItems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :line_items, :user, index: true, foreign_key: true
  end
end
