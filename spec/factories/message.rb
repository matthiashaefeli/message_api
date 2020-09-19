require 'faker'

FactoryBot.define do
  factory :message do
    message { Faker::ChuckNorris.fact }
    to_number { Faker::Number.number(digits: 10) }
    message_id { Faker::Number.number(digits: 10) }
  end
end