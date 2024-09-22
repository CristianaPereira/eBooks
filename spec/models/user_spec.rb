require 'rails_helper'

RSpec.describe User, type: :model do
  let(:new_user) { User.new(name: "Another User", username: "anotherUser", email: "anotherUser@gmail.com", password: "veryStrongPassword") }

  it "should create a new user with valid UserType" do
    new_user.user_type_id = 1
    new_user.save
    expect(new_user.user_type.name).to eq "Admin"
  end

  it "should raise RecordInvalid when user has invalid UserType" do
    new_user.user_type_id = 2
    new_user.save
    expect { new_user.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User type must exist")
  end

  it "should raise ActiveRecord::RecordInvalid when no name is provided" do
    expect { User.create!() }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User type must exist, Password can't be blank")
  end

  it "should raise RecordNotUnique when username is not unique" do
    new_user.user_type_id = 1
    new_user.username = "superAdmin"
    expect { new_user.save! }.to raise_error(ActiveRecord::RecordNotUnique, "SQLite3::ConstraintException: UNIQUE constraint failed: users.username")
  end
end
