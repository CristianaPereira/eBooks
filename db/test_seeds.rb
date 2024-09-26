
User.destroy_all

User.create(name: 'SuperAdmin', username: 'superAdmin', email: 'super.admin@gmail.com', password: 'veryStrongPassword')

20.times do
  User.create(
    name: Faker::Fantasy::Tolkien.character,
    username: Faker::Internet.username(specifier: 5..10),
    email: Faker::Internet.email,
    password: Faker::Internet.password)
end
