# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :last_name, :first_name, :email, :role, presence: true
  validate
  enum :role, { student: 'STUDENT', teacher: 'TEACHER' }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :refresh_tokens, dependent: :delete_all
  has_many :whitelisted_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all
  has_many :courses, dependent: :delete_all
  has_many :lessons, through: :courses
  has_many :groups, dependent: :delete_all, foreign_key: 'author_id', inverse_of: :author
end
