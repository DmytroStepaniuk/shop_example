class Store < ApplicationRecord
  has_many :purchase_orders
  has_many :availables, dependent: :destroy
  has_many :products, through: :availables
end
