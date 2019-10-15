FactoryBot.define do
  factory :business do
    business_name { "MyString" }
    user { association :user }
    location { "MyString" }
    rating { 1.5 }
    on_time_delivery { 1.5 }
    order_completion { 1.5 }
    last_month_earning { "9.99" }
  end
end
