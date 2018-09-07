require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }

  it { should belong_to(:product) }

  it { should have_many(:purchase_orders) }

  it { should callback(:set_price_and_calculate_total).before(:save) }

  it { should callback(:set_orders_total!).after(:save) }

  describe "#check_quantity" do
    it { expect { create_line_items(valide_qty: false) }.to raise_error(ActiveRecord::RecordInvalid) }

    it { expect { create_line_items(valide_qty: true) }.to_not raise_error(ActiveRecord::RecordInvalid) }
  end

  describe "#set_orders_total!" do
    before { expect(subject).to receive_message_chain(:order, :save!) }

    it { expect { subject.set_orders_total! }.to_not raise_error }
  end

  describe  "#set_price_and_calculate_total" do
    let(:product) { stub_model Product, price: 2 }

    let(:line_item) { stub_model LineItem, product: product, quantity: 3 }

    before { line_item.set_price_and_calculate_total }

    it { expect(line_item.total).to eq(6) }
  end

end
