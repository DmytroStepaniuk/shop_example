class CreateAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :availables do |t|
      t.integer :quantity
      t.belongs_to :store, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
