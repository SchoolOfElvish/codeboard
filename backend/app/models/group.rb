# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user
  validates :name, length: { minimum: 4, maximum: 20 }
end
