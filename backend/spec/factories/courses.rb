# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Hacker.say_something_smart }
    user { create(:teacher) }
  end
end
