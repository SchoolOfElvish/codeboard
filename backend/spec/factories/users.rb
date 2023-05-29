# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    role { 'STUDENT' }
  end

  factory :teacher, class: 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    role { 'TEACHER' }
  end
end
