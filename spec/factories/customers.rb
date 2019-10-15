FactoryBot.define do
  factory :customer do
    user { association :user }
  end
end
