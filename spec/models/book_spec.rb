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
  it "show raise an error when trying to updatebook status to a forbidden status" do
    expect { book.update!(status: 'someStatus') }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Status is not included in the list/)
  end
end
