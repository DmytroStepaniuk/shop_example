FactoryBot.define do
  MAX_DEFAULT_QTY = 3

  factory :user do
    sequence(:first_name) { |n| "users first name #{n}" }
    sequence(:last_name)  { |n| "users last name #{n}"  }

    password { 'password' }

    email { first_name.gsub(" ", "_") + "@test.com" }

    factory :user_with_session do
      after(:create) do |user|
        create(:session, user: user)
      end
    end

    factory :user_with_cart do
      after(:create) do |user|
        cart = create(:order, status: :cart, user: user)

        products = create_list :product, 3
        stores = create_list :store, 2

        products.each do |p|
          stores.each do |s|
            s.availables.create! product: p, quantity: MAX_DEFAULT_QTY
          end
        end

        products.each do |p|
          cart.line_items.create! product: p, quantity: (MAX_DEFAULT_QTY + 1)
        end
      end
    end
  end

  factory :session do
    user
  end

  factory :order do
    user
  end

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

  factory :available do
    store
    product
    quantity { MAX_DEFAULT_QTY }
  end

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

  factory :product do
    sequence(:name) { |n| "product #{n}" }
    sequence(:price)
  end
end
