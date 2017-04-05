class UserBannedSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :reputation, :status
end
