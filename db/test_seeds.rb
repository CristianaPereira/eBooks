
User.destroy_all

User.create(name: 'SuperAdmin', username: 'superAdmin', email: 'super.admin@gmail.com', password: 'veryStrongPassword')

15.times do
 new_user = FactoryBot.create(:user)
    # creates random companies
    rand(0..2).times do
      new_company = FactoryBot.create(:company, { user_id: new_user.id })
        # creates random ebooks
        rand(0..5).times do
          book= FactoryBot.create(:ebook, { company: new_company })
        end
    end
end
# creates random orders
# TODO: ensure that no user buys the same ebook twice ??
20.times do
  FactoryBot.create(:order, { user: User.all.sample, ebook: Ebook.all.sample })
end
