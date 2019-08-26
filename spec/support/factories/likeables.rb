FactoryBot.define do
  factory :likeable do
    association :video
    association :user
    status { :like }
  end
end
