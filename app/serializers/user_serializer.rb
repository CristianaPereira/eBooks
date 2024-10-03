class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :username, :email, :created_at, :updated_at, :avatar_url

  def avatar_url
    avatar = object.avatar
    rails_blob_path(avatar, only_path: true) if avatar.attached?
  end
end
