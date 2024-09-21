require 'rails_helper'

RSpec.describe UserType, type: :model do
  it "should create a new user type entry" do
    new_user_type = UserType.create(name: "Admin")
    expect(new_user_type.name).to eq "Admin"
  end

  it "should raise ActiveRecord::NotNullViolation when no name is provided" do
    expect { UserType.create() }.to raise_error(ActiveRecord::NotNullViolation)
  end
end
