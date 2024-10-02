require 'rails_helper'

RSpec.describe Ebook, type: :model do
  let(:ebook) { FactoryBot.create(:ebook) }

  context 'when testing books statuses update' do
    possible_statuses = Ebook.statuses.keys
    possible_statuses.each do |value|
      it "updates status to #{value}" do
        ebook.update(status: value)
        expect(ebook.status).to eq(value)
      end
    end
  end

  it "should create a new book associated to a company of an active user" do
    company_of_active_user = FactoryBot.create(:company)
    new_book = FactoryBot.create(:ebook, { company_id: company_of_active_user.id })

    expect(company_of_active_user.user.status).to eq('active')
    expect(new_book.company_id).to eq(company_of_active_user.id)
  end

  it "should raise ActiveRecord::RecordInvalid when trying to update book status to a forbidden status" do
    expect { ebook.update!(status: 'someStatus') }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Status is not included in the list/)
  end

  it "should raise an error when trying to create a book with a company of an inactive user" do
    company_of_inactive_user = FactoryBot.create(:company, user: FactoryBot.create(:user, status: 'inactive'))
    expect(company_of_inactive_user.user.status).to eq('inactive')
    expect { FactoryBot.create(:ebook, company_id: company_of_inactive_user.id) }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Company must exist/)
  end
end
