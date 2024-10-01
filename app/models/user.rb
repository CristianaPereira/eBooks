class User < ApplicationRecord
  has_secure_password

  before_save { self.email = email.downcase }

  validates_presence_of :email, :password, :username, :name

  # TODO: validates_uniqueness_of

  validates :username,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 15 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: EMAIL_REGEX }


  def as_json(options = {})
    # eg: options = {:status=>200}
    super(options.merge(except: [ :password_digest ]))
  end
end
