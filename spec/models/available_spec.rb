require 'rails_helper'

RSpec.describe Available, type: :model do
  it { should belong_to :store }
  it { should belong_to :product }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }

  describe "uniqueness_of_product_id" do
    let(:first_store) { Store.create }
    let(:second_store) { Store.create }
    let(:product) { Product.create }
    before { first_store.availables.create! product: product, quantity: 1 }

    it { expect { first_store.availables.create! product: product, quantity: 1 }.to raise_error(ActiveRecord::RecordInvalid) }

    it { expect { second_store.availables.create! product: product, quantity: 1 }.to_not raise_error(ActiveRecord::RecordInvalid) }
  end
end
