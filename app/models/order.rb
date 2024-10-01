class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ebook

  enum :status, { pending: "pending", finished: "finished" }, validate: { allow_nil: false }
end

# TODO: add cancelled status and allow to cancel order
