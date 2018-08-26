require 'rails_helper'

RSpec.describe Available, type: :model do
  it { should belong_to :store }
  it { should belong_to :product }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }

  describe "uniqueness_of_product_id" do
    let(:store1) { Store.create }
    let(:store2) { Store.create }
    let(:product) { Product.create }
    before { store1.availables.create! product: product, quantity: 1 }

    it do
      expect { store1.availables.create! product: product, quantity: 1 }
        .to raise_error ActiveRecord::RecordInvalid
    end
    it do
      expect { store2.availables.create! product: product, quantity: 1 }
        .to_not raise_error ActiveRecord::RecordInvalid
    end
  end
end
