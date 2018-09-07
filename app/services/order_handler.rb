class OrderHandler

  def initialize(user)
    @cart = user.cart
  end

  def pending!
    @cart.products.each do |product|
      line_item = @cart.line_items.find_by(product: product)

      still_needed = line_item.quantity

      availables = product.availables.includes(:store).order("stores.priority")

      availables.each do |available|
        next if still_needed == 0

        taked = available.quantity >= still_needed ? still_needed : available.quantity

        available.decrement! :quantity, taked

        line_item.purchase_orders.create! quantity: taked, store: available.store

        still_needed -= taked
      end
    end

    @cart.pending!
  end
end