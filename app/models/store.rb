class Store < ApplicationRecord
  has_many :purchase_orders
  has_many :availables
  has_many :products, through: :availables
end
