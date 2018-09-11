FactoryBot.define do
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
end