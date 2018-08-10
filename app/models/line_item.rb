class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
	before_save :set_price_and_calculate_total, :apt_quantity

	after_save :set_orders_total!

	#validates_numericality_of :quantity, equal_to: 1, on: :create
	#validates_inclusion_of    :quantity, in: 1..@qty, on: :update

	def set_orders_total!
		order.save!
	end
	
	def set_price_and_calculate_total
		self.price = product.price
		self.total = price * quantity
	end
		
	def apt_quantity
		@qty ||= self.product.availables.sum :quantity 
	  
    errors.add :quantity, 'is invalid' unless self.quantity.between?(1, @qty)
	end
end
