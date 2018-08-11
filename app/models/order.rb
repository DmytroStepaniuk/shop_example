class Order < ApplicationRecord
  enum status: [:cart, :pending, :accepted, :declained]

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items

  validates :user_id, uniqueness: true, if: :cart?

  before_save :calculate_total
  before_save :apt_product_decrement, if: :pending?

  def calculate_total
  	self.total = line_items.sum(:total)
  end

  def apt_product_decrement_from(store = Store.first)
    products.each do |p|
      apt_p = p.availables.find_by(store: store)
      li_p = line_items.find_by(product: p)

      qty = apt_p.quantity - li_p.quantity

      apt_p.update! quantity: qty
    end
  end

  def apt_product_decrement
    products.each do |p|
      apt_p = p.availables.find_by(product: p)
      li_p = line_items.find_by(product: p)

      qty = apt_p.quantity - li_p.quantity

      apt_p.update! quantity: qty
    end
  end

end
