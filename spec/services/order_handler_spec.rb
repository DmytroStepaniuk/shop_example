require 'rails_helper'

RSpec.describe OrderHandler do
  let(:user) { create :user }

  let(:cart) { create :order, status: :cart, user: user }

  let(:store1) { create :store, priority: 1 }
  let(:store2) { create :store, priority: 2 }

  before do
    products = create_list :product, 3

    stores = [store1, store2]

    products.each do |p|
      stores.each do |s|
        s.availables.create! product: p, quantity: MAX_DEFAULT_QTY
      end
    end

    products.each do |p|
      cart.line_items.create! product: p, quantity: (MAX_DEFAULT_QTY + 1)
    end
  end

  before { OrderHandler.new(user).pending! }

  describe 'pending!' do
    it "orders status cart changes to pending" do
      expect(user.orders.cart.count).to eq 0

      expect { OrderHandler.new(user).pending! }.to change{ user.orders.pending.count }.by(1)
    end

    it 'decrement availables in stors priority order' do
      expect(store1.availables.first.quantity).to  eq 0
      expect(store1.availables.second.quantity).to eq 0
      expect(store1.availables.third.quantity).to  eq 0
      expect(store2.availables.first.quantity).to  eq 2
      expect(store2.availables.second.quantity).to eq 2
      expect(store2.availables.third.quantity).to  eq 2
    end

    it 'create purchase orders in stors priority order' do
      expect(store1.purchase_orders.first.quantity).to  eq 3
      expect(store1.purchase_orders.second.quantity).to eq 3
      expect(store1.purchase_orders.third.quantity).to  eq 3
      expect(store2.purchase_orders.first.quantity).to  eq 1
      expect(store2.purchase_orders.second.quantity).to eq 1
      expect(store2.purchase_orders.third.quantity).to  eq 1
    end
  end
end
