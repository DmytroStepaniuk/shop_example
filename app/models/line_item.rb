class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: { greater_than: 0 }

	before_save :set_price_and_calculate_total

	after_save :set_orders_total!
	
	def set_orders_total!
		order.save!
	end
	
	def set_price_and_calculate_total
		self.price = product.price
		self.total = price * quantity
	end

end
