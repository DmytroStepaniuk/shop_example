require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many :line_items }
  
  it { should have_many(:orders).through(:line_items) }
  
  let(:product) { stub_model Product }
    
  it { expect(product.cover_image).to be_an_instance_of(ActiveStorage::Attached::One) }

  it { expect(product.photos).to be_an_instance_of(ActiveStorage::Attached::Many) }
  
end
