class CreateEbooks < ActiveRecord::Migration[7.2]
  def change
    create_table :ebooks do |t|
      t.string :title, null: false
      t.string :status, null: false, default: :draft
      t.integer :company_id, null: false
      t.index [ "company_id" ], name: "index_ebooks_on_company_id"
      t.decimal :price, precision: 4, scale: 2
      t.timestamps
    end
    add_foreign_key :ebooks, :companies
  end
end
# add_foreign_key "users", "user_types"
# https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
