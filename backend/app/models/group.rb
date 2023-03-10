# frozen_string_literal: true

class Group < ApplicationRecord
  validates :title, presence: true, length: { maximum: 256 }

  belongs_to :user
end