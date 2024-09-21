# populates user_types table with the base user groups
class AddBaseUserGroups < ActiveRecord::Migration[7.2]
  USER_GROUPS = [ 'Admin', 'Customer', 'Seller' ]
  def up
    USER_GROUPS.each do |group|
      UserType.create(name: group)
    end
  end

  def down
    UserType.where(name: USER_GROUPS).destroy_all
  end
end
