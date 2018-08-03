# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :commentable_id, :commentable_type
end
