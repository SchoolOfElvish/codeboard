# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    course { nil }
    title { 'MyString' }
    description { 'MyText' }
  end
end
