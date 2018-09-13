class AddTypeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :type, :integer
  end
end
