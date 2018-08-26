class Order < ApplicationRecord
  enum status: [:cart, :pending, :accepted, :declained, :preorder]

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items
  has_many :purchase_orders, through: :line_items

  validates :user_id, uniqueness: true, if: :cart?

  before_save :calculate_total

  def calculate_total
  	self.total = line_items.sum(:total)
  end

end
