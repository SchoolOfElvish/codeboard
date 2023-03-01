# frozen_string_literal: true

class Lesson < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  belongs_to :course
end
