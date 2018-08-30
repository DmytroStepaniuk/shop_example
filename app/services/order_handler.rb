class OrderHandler

  def initialize(user)
    @user, @cart = user, user.cart
  end

  def pending!
    @cart.products.each do |product|
      line_item = @cart.line_items.find_by(product: product)

      still_needed = line_item.quantity

      availables = product.availables.includes(:store).order("stores.priority")

      enough = false

      availables.each do |available|
        available_qty, store = available.quantity, available.store

        remains = available_qty.downto 0 do |i|
                    break i if still_needed == 0 || i == 0
                    still_needed -= 1
                  end
        unless enough
          available.update! quantity: remains
          taked = available_qty - remains
          line_item.purchase_orders.create! quantity: taked, store: store
        end
        enough = true if still_needed == 0
      end
    end
  end
end