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

    context "can't create same product in the store again" do
      it { expect { first_store.availables.create! product: product, quantity: 1 }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context "but can create same product in another store" do
      it { expect { second_store.availables.create! product: product, quantity: 1 }.to_not raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
