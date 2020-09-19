require 'faker'

FactoryBot.define do
  factory :provider do
    name { Faker::Artist.name }
    url { Faker::Internet.url }
    load { Faker::Number.within(range: 10..100) }
  end
end