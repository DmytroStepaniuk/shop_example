class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: { greater_than: 0 }

	before_create do
		self.price = product.price
		self.total = product.price * quantity
	end

  before_update { self.total = price * quantity }

end
