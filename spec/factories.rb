FactoryBot.define do
  factory :user do
    name { Faker::Fantasy::Tolkien.character }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.username(specifier: 5..10) }

    trait :with do
      password { Faker::Internet.password }
    end
  end
end
