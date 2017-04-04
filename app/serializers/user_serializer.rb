class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :reputation
end
