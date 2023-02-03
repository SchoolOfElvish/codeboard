class Course < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 } 

  belongs_to :user
end