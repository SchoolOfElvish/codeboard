# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    a = FactoryBot.create(:user)
    b = Group.create(name: "Sawq", author_id: a.id)
  end
end