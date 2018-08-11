puts "\nRun seeds...\n"

u = User.create! first_name: 'Luke', last_name: 'Keks', email: 'Luke@keks.com', password: '123456'
pp u

s = User.first.sessions.create!
puts '', "auth_token:", s.auth_token, ''

[[name: 'p1', price: '1'],
 [name: 'p2', price: '11'],
 [name: 'p3', price: '22']].map { |p| Product.create! p }
puts "products are created\n\n"

store = Store.create name: 'Luka'
Product.all.each do |p| 
  store.availables.create! product: p, quantity: 4
end
puts "store and available products were created\n\n"

User.first.cart.save!
[{product_id: 1, quantity: 1},
 {product_id: 2, quantity: 2},
 {product_id: 3, quantity: 3}].map { |l| u.cart.line_items.create! l }
pp User.first.cart.line_items

puts ''

pp User.first.cart
