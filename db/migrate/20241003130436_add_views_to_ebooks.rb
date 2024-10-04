class AddViewsToEbooks < ActiveRecord::Migration[7.2]
  def change
    add_column :ebooks, :total_previews, :integer, default: 0, null: false
  end
end
