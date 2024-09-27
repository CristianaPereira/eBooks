module UserConcern
  extend ActiveSupport::Concern
  include FilterConcern

  included do
    scope :by_username, ->(username) { where("username LIKE ?", "%#{username}%") if username.present? }
    scope :by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
  end
end
