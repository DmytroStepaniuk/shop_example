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
  let(:h) { create_line_items }

  subject { OrderHandler.new(h[:user]) }

  describe 'pending!' do
    before do
      expect(h[:store1].availables.first.quantity).to  eq 4
      expect(h[:store1].availables.second.quantity).to eq 4
      expect(h[:store1].availables.third.quantity).to  eq 4
      expect(h[:store2].availables.first.quantity).to  eq 2
      expect(h[:store2].availables.second.quantity).to eq 2
      expect(h[:store2].availables.third.quantity).to  eq 2
    end

    before do
      expect(h[:user].cart.line_items.first.quantity).to  eq 1
      expect(h[:user].cart.line_items.second.quantity).to eq 2
      expect(h[:user].cart.line_items.third.quantity).to  eq 6
    end

    before { subject.pending! }

    context 'decrement availables' do
      it { expect(h[:store1].availables.first.quantity).to  eq 3 }
      it { expect(h[:store1].availables.second.quantity).to eq 2 }
      it { expect(h[:store1].availables.third.quantity).to  eq 0 }
      it { expect(h[:store2].availables.first.quantity).to  eq 2 }
      it { expect(h[:store2].availables.second.quantity).to eq 2 }
      it { expect(h[:store2].availables.third.quantity).to  eq 0 }
    end

    context 'creating purchase orders' do
      it { expect(h[:store1].purchase_orders.first.quantity).to  eq 1 }
      it { expect(h[:store1].purchase_orders.second.quantity).to eq 2 }
      it { expect(h[:store1].purchase_orders.third.quantity).to  eq 4 }
      it { expect(h[:store2].purchase_orders.first.quantity).to  eq 2 }
    end
  end
end
