# class OrderHandler

#   def initialize(user)
#     @cart = user.cart
#   end

#   def pending!
#     @cart.products.each do |product|
#       line_item = @cart.line_items.find_by(product: product)

#       still_needed = line_item.quantity

#       availables = product.availables.includes(:store).order("stores.priority")

#       availables.each do |available|
#         next if still_needed.to eq 0

#         taked = available.quantity >= still_needed ? still_needed : available.quantity

#         available.decrement! :quantity, taked

#         line_item.purchase_orders.create! quantity: taked, store: available.store

#         still_needed -= taked
#       end
#     end

#   @cart.pending!
#   end
# end

require 'rails_helper'

RSpec.describe OrderHandler do
  let(:user) { create :user_with_cart }

  before { OrderHandler.new(user).pending! }

  describe 'pending!' do
    let(:products) { user.orders.find_by(status: :pending).products }
    let(:store1)   { products.first.availables.first.store }
    let(:store2)   { products.first.availables.second.store }

    context 'decrement availables' do
      it { expect(products.first.availables.first.quantity).to   eq 0 }
      it { expect(products.second.availables.first.quantity).to  eq 0 }
      it { expect(products.third.availables.first.quantity).to   eq 0 }
      it { expect(products.first.availables.second.quantity).to  eq 2 }
      it { expect(products.second.availables.second.quantity).to eq 2 }
      it { expect(products.third.availables.second.quantity).to  eq 2 }
    end

    context 'creating purchase orders' do
      it { expect(store1.purchase_orders.first.quantity).to  eq 3 }
      it { expect(store1.purchase_orders.second.quantity).to eq 3 }
      it { expect(store1.purchase_orders.third.quantity).to  eq 3 }
      it { expect(store2.purchase_orders.first.quantity).to  eq 1 }
      it { expect(store2.purchase_orders.second.quantity).to eq 1 }
      it { expect(store2.purchase_orders.third.quantity).to  eq 1 }
    end
  end
end
