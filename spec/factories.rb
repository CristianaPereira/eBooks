FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :ebook, factory: :ebook
    total { Faker::Number.decimal(l_digits: 2) }
  end

  factory :user do
    name { Faker::Fantasy::Tolkien.character }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.username(specifier: 5..10) }
  end

  factory :company do
    name { Faker::Books::CultureSeries.book }
    association :user, factory: :user
  end

  factory :ebook do
    title { Faker::Book.title }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Ebook.statuses.values.sample }
    association :company, factory: :company
  end
end
