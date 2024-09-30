
User.destroy_all

User.create(name: 'SuperAdmin', username: 'superAdmin', email: 'super.admin@gmail.com', password: 'veryStrongPassword')

15.times do
 new_user =  User.create(
    name: Faker::Fantasy::Tolkien.character,
    username: Faker::Internet.username(specifier: 5..10),
    email: Faker::Internet.email,
    password: Faker::Internet.password)

    puts "User #{new_user.name} created"


    # creates random companies
    rand(0..2).times do
      new_company = Company.create(
        name: Faker::Company.name,
        user_id: new_user.id)
        puts "Company #{new_company.name} created for user_id: #{new_user.id}"
        # creates random ebooks
        rand(0..5).times do
          new_ebook = Ebook.create(
            title: Faker::Book.title,
            status: Ebook.statuses.keys.sample,
            price: Faker::Number.decimal(l_digits: 2),
            company: new_company)
            puts "Ebook #{new_ebook.title} created for company_id: #{new_company.id}"
        end
    end
end
