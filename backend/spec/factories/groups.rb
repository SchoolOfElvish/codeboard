# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    author_last_name { 'SAWQ' }
    author { association :author, last_name: author_last_name }
    name { 'MyString' }
    user_id { 1 }
  end
end
