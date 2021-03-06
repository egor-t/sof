# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body 'MyText'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
  end
end
