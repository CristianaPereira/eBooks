class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ebook
  before_save :ensure_user_is_active

  enum :status, { pending: "pending", finished: "finished" }, validate: { allow_nil: false }

  private

  def ensure_user_is_active
    return true if user.active?

    errors.add(:user, "must exist")
    raise ActiveRecord::RecordInvalid.new(self)
  end
end

# TODO: add cancelled status and allow to cancel order
