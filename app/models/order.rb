class Order < ApplicationRecord
  enum status: [:cart, :pending, :accepted, :declained]

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items
  
  validates :user_id, uniqueness: true, if: :cart?

  def update_total
  	update total: line_items.sum(:total)
  end
  
end
