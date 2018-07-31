require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }
  
  it { should belong_to(:product) }
  
  it { should callback(:set_price_and_calculate_total).before(:save) }
  
  it { should callback(:set_orders_total).after(:save) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }
end
