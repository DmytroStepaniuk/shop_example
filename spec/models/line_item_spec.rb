require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }
  
  it { should belong_to(:product) }
  
  it { should callback(:set_price_and_calculate_total).before(:save) }
  
  it { should callback(:set_orders_total!).after(:save) }
  
  let(:product) { stub_model Product, price: 2 }
    
  let(:line_item) { stub_model LineItem, product: product, quantity: 3 }
  
  let(:available) { stub_model Available, quantity: 4, product: product }
  
  describe "apt_quantity" do
    before do 
      expect(subject).to receive_message_chain(:product, :availables, :sum)
                          .with(no_args).with(no_args).with(:quantity)
    end
    
    xit {  }
  end
  
  describe "#set_orders_total!" do
    before { expect(subject).to receive_message_chain(:order, :save!) }
    
    it { expect { subject.set_orders_total! }.to_not raise_error }
  end

  describe  "#set_price_and_calculate_total" do
    before { line_item.set_price_and_calculate_total }
    
    it { expect(line_item.total).to eq(6) }
  end
  
end
