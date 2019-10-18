# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    name { 'MyString' }
    from_date { '2019-10-16' }
    to_date { '2019-10-16' }
    from_time { '2019-10-16 07:44:08' }
    to_time { '2019-10-16 09:44:08' }
    is_completed { false }
    description { 'MyString' }
    headline { 'MyString' }
  end
end
