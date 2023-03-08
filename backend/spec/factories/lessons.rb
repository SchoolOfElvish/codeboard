# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    course
    title { 'MyString' }
    description { 'MyText' }
  end
end
