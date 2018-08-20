class Store < ApplicationRecord
  has_many :availables
  has_and_belongs_to_many :orders
  has_many :products, through: :availables
end
