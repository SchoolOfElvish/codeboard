# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    course
    title { Faker::Hacker.say_something_smart }
    description { Faker::Hipster.paragraphs.join(' ') }
  end
end
