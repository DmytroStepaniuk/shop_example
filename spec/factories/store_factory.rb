FactoryBot.define do
  factory :store do
    sequence(:priority)
    sequence(:location) { |n| "Somewhere #{n}" }
    sequence(:name)     { |n| "Store #{n}" }

    factory :store_with_availables do
      after :create do |store|
        create_list :available, MAX_DEFAULT_QTY, store: store
      end
    end
  end
end