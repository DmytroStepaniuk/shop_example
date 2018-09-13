class Product < ApplicationRecord
  has_many :line_items
  has_many :availables
  has_many_attached :photos
  has_one_attached :cover_image
  has_many :orders, through: :line_items
  has_many :stores, through: :availables
end
