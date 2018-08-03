# frozen_string_literal: true

ThinkingSphinx::Index.define :comment, with: :active_record do
  # fields
  indexes body
  indexes user.username, as: :author, sortable: true

  # attributes
  has user_id
  has commentable_id, created_at, updated_at
end
