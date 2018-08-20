class Order < ApplicationRecord
  enum status: [:cart, :pending, :accepted, :declained, :preorder]

  enum kind: [:online, :offline]

  belongs_to :user
  has_many :line_items
  has_and_belongs_to_many :stores
  has_many :products, through: :line_items

  validates :user_id, uniqueness: true, if: :cart?

  before_save :calculate_total
  before_save :apt_product_decrement, if: [:pending?, :online?]
  before_save :apt_product_decrement_from_store, if: [:pending?, :offline?]

  def calculate_total
  	self.total = line_items.sum(:total)
  end

  def apt_product_decrement_from_store
    products.each do |p|
      apt_p = p.availables.find_by(store: self.store)
      li_p = line_items.find_by(product: p)

      qty = apt_p.quantity - li_p.quantity

      apt_p.update! quantity: qty
    end
  end

  def apt_product_decrement
    products.each do |p|
      li = line_items.find_by(product: p).quantity
      enough = false
      p.availables.includes(:store).order("stores.priority").each do |av|
        qty = av.quantity.downto 0 do |i|
                break i if li == 0 || i == 0
                li -= 1
              end
        av.update quantity: qty unless enough
        enough = true if li == 0
      end
    end
  end
end
