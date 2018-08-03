require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should define_enum_for(:status).with [:cart, :pending, :accepted, :declained] }
  
  it { should have_many(:line_items) }
  
  it { should have_many(:products).through(:line_items) }
  
  it { should belong_to(:user) }
  
  it { should callback(:calculate_total).before(:save) }
  
  describe "uniqueness_of_user_id" do
    let(:user) { User.create email: "test@test.com", password: "123456" }
  
    before { user.orders.create(status: :cart) }
    
    it { expect { user.orders.create!(staus: :cart) }.to raise_error }
  end
  
  describe "#calculate_total" do
    before { expect(subject).to receive_message_chain(:line_items, :sum).with(no_args).with(:total) }
    
    it { expect { subject.calculate_total }.to_not raise_error }
  end
  
end
