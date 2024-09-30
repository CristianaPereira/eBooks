
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
