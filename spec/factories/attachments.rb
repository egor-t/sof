FactoryBot.define do
  factory :attachment do
    file File.open("#{Rails.root}/spec/spec_helper.rb")
    trait :attachable do
    end
  end
end