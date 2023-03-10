# frozen_string_literal: true

class Course < ApplicationRecord
  validates :name, presence: true, length: { maximum: 256 }

  belongs_to :user
  has_many :lessons, dependent: :delete_all
end
