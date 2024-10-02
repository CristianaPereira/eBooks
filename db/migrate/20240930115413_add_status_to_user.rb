class AddStatusToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :status, :string, default: :active, null: false
  end
end
