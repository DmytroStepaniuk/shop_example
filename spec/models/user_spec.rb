require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  
  it { should have_many(:sessions).dependent(:destroy) }
  
  it { should have_many(:orders).dependent(:destroy) }
  
  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email).case_insensitive }
  
  it { should validate_length_of(:password).is_at_least(6) }
  
  describe "#cart" do
    before do
      expect(subject).to receive_message_chain(:orders, :find_or_initialize_by).
        with(no_args).with(status: :cart)
    end
    
    it { expect { subject.send(:cart) }.to_not raise_error }
  end
end
