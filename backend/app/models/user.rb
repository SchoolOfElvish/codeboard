# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :refresh_tokens, dependent: :delete_all
  has_many :whitelisted_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all
end
