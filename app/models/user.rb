class User < ApplicationRecord
  include UserConcern
  has_many :companies

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


  # scope :by_author, ->(name) { joins(:author).where("author.name LIKE ?", "%#{name}%") if name.present? }

  # Usage: rails c > User.filter("arrett", "tom")
  def self.filter(name, username)
    by_name(name).by_username(username)
  end

  def my_method
    puts "Hi from my_method"
  end

  def as_json(options = {})
    # eg: options = {:status=>200}
    super(options.merge(except: [ :password_digest ]))
  end
end


# > User.filter('arrett', 'tom') [OK]

# > User.concern_c_hi [OK]
# > User.first.concern_i_hi [ERROR (undefined method)]

# > User.concern_private_hi => Error (private method)

# > User.first.concern_i_hi [OK]
# > User.concern_i_hi => Error (undefined method)

# > User.first.my_method [OK]
# > User.my_method [ERROR (undefined method)]
