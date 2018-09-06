class RemoveStoreFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:orders, :store, index: true, foreign_key: true)
  end
end
