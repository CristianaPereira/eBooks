require 'rails_helper'

RSpec.describe Order, type: :model do
  it "should successfully create a new book order" do
    expect(Order.create!(ebook: Ebook.all.sample, user: User.all.sample)).to eql(Order.last)
  end

  it "should raise error when user is inactive" do
    user_to_disable = User.all.sample
    user_to_disable.destroy
    expect { Order.create!(ebook: Ebook.all.sample, user_id: user_to_disable.id) } .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User must exist")
    expect { Order.create!(ebook: Ebook.all.sample, user: user_to_disable) } .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User must exist")
  end

  it "should raise error when user does not exist" do
    unkown_user_id = User.last.id + 1
    expect { Order.create!(ebook: Ebook.all.sample, user_id: unkown_user_id) } .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User must exist")
  end
end
