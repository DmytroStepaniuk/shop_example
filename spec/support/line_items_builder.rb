module LineItemsBuilder
  def create_line_items(valide_qty: true)
    u = User.create!(first_name: 'Luke',
                     last_name: 'Keks',
                     email: "luke#{rand}@keks.com",
                     password: '123456')

    [[name: 'p1', price: '1'],
     [name: 'p2', price: '11'],
     [name: 'p3', price: '22']].map { |p| Product.create! p }

    store1 = Store.create name: 'Luka', priority: 1
    Product.all.each do |p|
      store1.availables.create! product: p, quantity: 4
    end

    store2 = Store.create name: 'Saturn', priority: 2
    Product.all.each do |p|
      store2.availables.create! product: p, quantity: 2
    end

    u.cart.save!

    if valide_qty
      [{product: Product.first,  quantity: 1},
       {product: Product.second, quantity: 2},
       {product: Product.third,  quantity: 6}].map { |l| u.cart.line_items.create! l }
    end

    unless valide_qty
      [{product: Product.first,  quantity: -1},
       {product: Product.second, quantity:  0},
       {product: Product.third,  quantity:  7}].map { |l| u.cart.line_items.create! l }
    end

    return {user: u, store1: store1, store2: store2}
  end
end