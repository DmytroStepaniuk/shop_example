class Available < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  validates :product_id, uniqueness: true
end
