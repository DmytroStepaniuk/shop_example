class Store < ApplicationRecord
  has_many :products, through: :availables
  has_many :availables
end
