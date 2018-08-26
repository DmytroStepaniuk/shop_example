class CreatePurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_orders do |t|
      t.references :line_item, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
