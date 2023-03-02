# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :name, length: { minimum: 4 }
end
