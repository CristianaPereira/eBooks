class Company < ApplicationRecord
  belongs_to :user
  has_many :ebooks

  # ensure in default scope that only companies with active users are returned
  default_scope { joins(:user).where(users: { status: "active" }) }
end

# TODO:
# allow full destroy if !books.length
