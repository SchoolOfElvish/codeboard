# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { 'MyString' }
    user
  end
end
