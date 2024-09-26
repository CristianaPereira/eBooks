class Ebook < ApplicationRecord
  belongs_to :company
  enum status: { draft: "draft", pending: "pending", live: "live" }
end
