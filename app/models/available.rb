class Available < ApplicationRecord
  belongs_to :store
  belongs_to :product
    
  validates :quantity, numericality: { greater_than: 0 }
end
