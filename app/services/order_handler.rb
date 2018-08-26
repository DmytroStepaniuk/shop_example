class OrderHandler

  def initialize(user)
    @user, @cart = user, user.cart
  end

  def pending!
    @cart.products.each do |p|
      li = @cart.line_items.find_by(product: p)

      li_q = li.quantity

      enough = false

      p.availables.includes(:store).order("stores.priority").each do |av|
        av_q = av.quantity

        qty = av_q.downto 0 do |i|
                break i if li_q == 0 || i == 0
                li_q -= 1
              end
        unless enough
          av.update quantity: qty
          li.purchase_orders.create! quantity: av_q - qty, store: av.store
        end
        enough = true if li_q == 0
      end
    end
  end
end