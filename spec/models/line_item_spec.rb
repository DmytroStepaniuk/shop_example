require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }
  
  it { should belong_to(:product) }
  
  it { should callback(:set_price_and_calculate_total).before(:save) }
  
  it { should callback(:set_orders_total!).after(:save) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }
  
  describe "#set_orders_total!" do
    before { expect(subject).to receive_message_chain(:order, :save!) }
    
    it { expect { subject.send(:set_orders_total!) }.to_not raise_error }
  end

  # describe  "#set_price_and_calculate_total" do
  #   let(:product) { stub_model Product, price: 2, id: 1 }
    
  #   let(:line_item) { stub_model LineItem, product_id: 1, order_id: 1, quantity: 3 }
    
  #   before { expect(subject).to receive(:price=).with(2) }
    
  #   before { expect(subject).to receive(:total=).with(6) }
    
  #   before { expect(line_item).to receive(:set_price_and_calculate_total) }
    
  #   it { expect(line_item.total).to eq(6) }
  # end
end
