# frozen_string_literal: true

class WhitelistedToken < ApplicationRecord
  belongs_to :user
end
