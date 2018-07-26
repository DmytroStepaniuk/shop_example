User.create first_name: 'Luke', last_name: 'Keks', email: 'Luke@keks.com', password: '213123'
k = User.first.sessions.create
puts "auth_token:", k.auth_token 