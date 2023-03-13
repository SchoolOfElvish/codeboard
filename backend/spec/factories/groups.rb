# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name { 'English Group' }
    author { association :user }
  end
end
