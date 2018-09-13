FactoryBot.define do
  factory :line_item do
    order
    product
    quantity { MAX_DEFAULT_QTY }

    trait :with_qty_greater_than_available do
      quantity { MAX_DEFAULT_QTY + 1 }
    end

    trait :with_zero_qty do
      quantity { 0 }
    end

    after(:build) do |line_item|
      create :available, product: line_item.product
    end
  end
end