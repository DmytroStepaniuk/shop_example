module Builder
  def create_line_items_with_valide_qty
    u = User.create!(
      first_name: 'Luke',
      last_name: 'Keks',
      email: 'Luke@keks.com',
      password: '123456')

    s = User.first.sessions.create!

    [[name: 'p1', price: '1'],
     [name: 'p2', price: '11'],
     [name: 'p3', price: '22']].map { |p| Product.create! p }

    store = Store.create name: 'Luka', priority: 1
    Product.all.each do |p|
      store.availables.create! product: p, quantity: 4
    end

    store2 = Store.create name: 'Saturn', priority: 2
    Product.all.each do |p|
      store2.availables.create! product: p, quantity: 2
    end

    User.first.cart.save!

    [{product_id: 1, quantity: 1},
     {product_id: 2, quantity: 2},
     {product_id: 3, quantity: 6}].map { |l| u.cart.line_items.create! l }
  end

  def create_line_items_with_invalide_qty
    u = User.create!(
      first_name: 'Luke',
      last_name: 'Keks',
      email: 'Luke@keks.com',
      password: '123456')

    s = User.first.sessions.create!

    [[name: 'p1', price: '1'],
     [name: 'p2', price: '11'],
     [name: 'p3', price: '22']].map { |p| Product.create! p }

    store = Store.create name: 'Luka', priority: 1
    Product.all.each do |p|
      store.availables.create! product: p, quantity: 4
    end

    store2 = Store.create name: 'Saturn', priority: 2
    Product.all.each do |p|
      store2.availables.create! product: p, quantity: 2
    end

    User.first.cart.save!

    [{product_id: 1, quantity: -1},
     {product_id: 2, quantity: 0},
     {product_id: 3, quantity: 7}].map { |l| u.cart.line_items.create! l }
  end


end