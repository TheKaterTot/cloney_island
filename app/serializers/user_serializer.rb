class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :reputation
end
