require 'rails_helper'

RSpec.describe UserType, type: :model do
  it "should create a new user type" do
    new_user_type = UserType.create!(name: "Another User Type")
    expect(new_user_type.name).to eq "Another User Type"
  end

  it "should raise ActiveRecord::NotNullViolation when no name is provided" do
    expect { UserType.create!() }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "should raise ActiveRecord::RecordNotUnique when name already exists in db" do
    expect { UserType.create!(name: "Admin") }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
