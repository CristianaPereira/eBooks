require 'rails_helper'

RSpec.describe User, type: :model do
  it "should raise ActiveRecord::RecordInvalid when no data is provided" do
    expect {
      User.create!()
    }.to raise_error(ActiveRecord::RecordInvalid) do |error|
      expect(error.record.errors.as_json).to eq({
        email: [ "can't be blank", "is invalid" ],
        name: [ "can't be blank" ],
        password: [ "can't be blank" ],
        username: [ "can't be blank", "is too short (minimum is 3 characters)" ]
      })
     end
  end

  it "should raise RecordNotUnique when username is not unique" do
    expect { FactoryBot.create(:user, { username: 'superAdmin' }) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Username has already been taken")
  end

  it "should disable(fake destroy) an active user" do
    user_to_disable = User.find_by(status: "active")
    user_to_disable.destroy
    expect(user_to_disable.status).to eq("inactive")
  end

  it "should not find and inactive user" do
    user_to_disable = User.find_by(status: "active")
    user_to_disable.destroy
    expect { User.find(user_to_disable.id) }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find User/)
  end
end
