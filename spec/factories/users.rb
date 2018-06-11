FactoryBot.define do
  sequence :email do |n|
    "user#{n}@mail.ru"
  end

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end

  factory :invalid_user do
    email
    password ''
    password_confirmation ''
  end
end