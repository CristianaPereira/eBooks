require 'rails_helper'

RSpec.describe User, type: :model do
  let(:new_user) { User.new(name: "Another User", username: "anotherUser", email: "anotherUser@gmail.com", password: "veryStrongPassword") }

  it "should raise ActiveRecord::RecordInvalid when no password is provided" do
    expect { User.create!() }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
  end

  it "should raise RecordNotUnique when username is not unique" do
    new_user.username = "superAdmin"
    expect { new_user.save! }.to raise_error(ActiveRecord::RecordNotUnique, "SQLite3::ConstraintException: UNIQUE constraint failed: users.username")
  end
end
