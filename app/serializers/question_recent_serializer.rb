class QuestionRecentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :category_id, :category_name
end