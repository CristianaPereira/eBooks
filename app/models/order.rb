class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ebook

  enum :status, { pending: "pending", finished: "finished" }, validate: { allow_nil: false }
  validate :ensure_user_is_active


  private

  def ensure_user_is_active
    errors.add(:user, "must exist") unless user.present? && user.active?
  end
end

# TODO: add cancelled status and allow to cancel order
