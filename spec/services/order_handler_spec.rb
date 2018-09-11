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
