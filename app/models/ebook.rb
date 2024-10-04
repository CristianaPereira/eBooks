class Ebook < ApplicationRecord
  include Filterable
  include Attachable

  belongs_to :company
  has_one :user, through: :company
  has_many :orders
  has_one_attached :preview
  has_one_attached :full_ebook


  validates_presence_of :title, :price, :status
  enum :status, { draft: "draft", pending: "pending", live: "live" }, validate: { allow_nil: false }

  scope :by_name, ->(name) { where("ebooks.name LIKE ?", "%#{name}%") if name.present? }

  scope :by_owner_id, ->(owner_id) { joins(:company).where("companies.user_id = ?", owner_id) if owner_id.present? }

  def as_json(options = {})
    # eg: options = {:status=>200}
    # TODO: explore serializers
    super(options).merge({ company: company }).merge(hasPreview: preview.attached?)
  end
end


# TODO:
# allow full destroy if !orders.length
