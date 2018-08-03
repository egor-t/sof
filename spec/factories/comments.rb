# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    body 'Comment'
    association :commentable, factory: :question
  end
end
