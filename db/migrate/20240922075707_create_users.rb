class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.references :user_type, null: false, foreign_key: true # Adds user_type_id column with a foreign key
      # t.belongs_to :user_type, null: false, foreign_key: true  # Adds user_type_id column with a foreign key

      t.timestamps
    end
  end
end
