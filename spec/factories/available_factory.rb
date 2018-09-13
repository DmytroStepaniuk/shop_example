FactoryBot.define do
  factory :available do
    store
    product
    quantity { MAX_DEFAULT_QTY }
  end
end