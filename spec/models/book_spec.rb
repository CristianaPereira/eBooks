require 'rails_helper'

RSpec.describe Ebook, type: :model do
  let(:book) { Ebook.first }

  context 'when testing books statuses update' do
    possible_statuses = Ebook.statuses.keys
    possible_statuses.each do |value|
      it "updates status to #{value}" do
        book.update(status: value)
        expect(book.status).to eq(value)
      end
    end
  end

  it "should create a new book associated to a company of an active user" do
    # TODO: use factory bot to create a company with an inactive user
    # find company of an active user
    company_of_active_user = Company.joins(:user).where("users.status": 'active').first

    new_book = Ebook.create!(title: Faker::Book.title, price: Faker::Number.decimal(l_digits: 2), status: Ebook.statuses.values.sample, company_id: company_of_active_user.id)

    expect(new_book.company_id).to eq(company_of_active_user.id)
  end

  it "should raise ActiveRecord::RecordInvalid when trying to update book status to a forbidden status" do
    expect { book.update!(status: 'someStatus') }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Status is not included in the list/)
  end

  it "should raise an error when trying to create a book with a company of an inactive user" do
    # TODO: use factory bot to create a company with an inactive user
    company_of_user_to_disable = Company.joins(:user).where("users.status": 'active').first
    company_of_user_to_disable.user.destroy

    new_book = Ebook.new(title: Faker::Book.title, price: Faker::Number.decimal(l_digits: 2), status: Ebook.statuses.values.sample, company_id: company_of_user_to_disable.id)

    expect { new_book.save! }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Company must exist/)
  end
end
