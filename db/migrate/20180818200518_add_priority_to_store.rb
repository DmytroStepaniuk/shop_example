class AddPriorityToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :priority, :integer
  end
end
