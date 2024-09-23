require 'rails_helper'

RSpec.describe User, type: :model do
  let(:new_user) { User.new(name: "Another User", username: "anotherUser", email: "anotherUser@gmail.com", password: "veryStrongPassword") }

  it "should raise ActiveRecord::RecordInvalid when no password is provided" do
    expect { User.create!() }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank, Name can't be blank, Password can't be blank, Username can't be blank, Username is too short (minimum is 3 characters), Email can't be blank, Email is invalid")
  end

  it "should raise RecordNotUnique when username is not unique" do
    new_user.username = "superAdmin"
    expect { new_user.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Username has already been taken") end
end
