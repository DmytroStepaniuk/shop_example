require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }
  
  it { should belong_to(:product) }
  
  it { should callback(:set_price_and_calculate_total).before(:save) }
  
  it { should callback(:set_orders_total!).after(:save) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }
  
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
