class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :password, presence: true

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 15 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: EMAIL_REGEX }
end
