class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :status, null: false, default: :pending
      t.references :user, null: false, foreign_key: true
      t.references :ebook, null: false, foreign_key: true
      t.decimal :total, precision: 4, scale: 2

      t.timestamps
    end
  end
end
