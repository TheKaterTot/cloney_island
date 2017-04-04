class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :reputation
end
