FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "product #{n}" }
    sequence(:price)
  end
end