class User < ApplicationRecord
  include Filterable
  include SoftDeletable

  has_many :companies
  has_many :ebooks, through: :companies # allows to access ebooks through companies eg: User.find(16).ebooks
  has_many :orders

  has_secure_password

  before_save { self.email = email.downcase }

  enum :status, { active: "active", inactive: "inactive" }, validate: { allow_nil: false }

  validates_presence_of :email, :password, :username, :name, :status

  # TODO: validates_uniqueness_of

  validates :username,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 15 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: EMAIL_REGEX }

  default_scope { where(status: "active") }
  scope :by_username, ->(username) { where("username LIKE ?", "%#{username}%") if username.present? }
  scope :by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }

  def soft_delete
    update_column :status, :inactive
    # TODO: update corresponding ebooks to ghost user ?
    # TODO: update corresponding orders to ghost user ?
  end

  def as_json(options = {})
    # eg: options = {:status=>200}
    super(options.merge(except: [ :password_digest ]))
  end
end
