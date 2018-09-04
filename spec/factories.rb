FactoryBot.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    email      'john@doe.com'
    password   '123456'

    after :create do |variable|

    end
  end

  factory :session do
    user
  end

  factory :line_item do

  end
[[name: 'p1', price: '1'],
 [name: 'p2', price: '11'],
 [name: 'p3', price: '22']].map { |p| Product.create! p }
puts "products are created\n\n"

store = Store.create name: 'Luka', priority: 1
Product.all.each do |p|
  store.availables.create! product: p, quantity: 4
end

store2 = Store.create name: 'Saturn', priority: 2
Product.all.each do |p|
  store2.availables.create! product: p, quantity: 2
end
puts "stores and available products were created\n\n"

User.first.cart.save!

[{product_id: 1, quantity: 1},
 {product_id: 2, quantity: 2},
 {product_id: 3, quantity: 6}].map { |l| u.cart.line_items.create! l }

end