require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should define_enum_for(:status).with [:cart, :pending, :accepted, :declained] }
  
  it { should have_many(:line_items) }
  
  it { should have_many(:products).through(:line_items) }
  
  it { should belong_to(:user) }
  
  it { should callback(:calculate_total).before(:save) }
  
  # describe "uniqueness_of_user_id" do
  #   before { allow(subject).to receive(:cart?).and_return(true)  }
    
  #   it { should validate_uniqueness_of(:user_id) }
  # end
  
  describe "#calculate_total" do
    before { expect(subject).to receive_message_chain(:line_items, :sum).with(no_args).with(:total) }
    
    it { expect { subject.send(:calculate_total) }.to_not raise_error }
  end
  
end
