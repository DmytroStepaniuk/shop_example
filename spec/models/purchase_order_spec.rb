require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  it { should belong_to :line_item }
  it { should belong_to :store }
end
