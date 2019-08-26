FactoryBot.define do
  factory :video do
    association :user
    uuid { "MyString" }
    video_url { "MyString" }
  end
end
