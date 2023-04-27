# frozen_string_literal: true

class EmailJob < ApplicationJob::Base
  queue_as :default

  def perform(user)
    UserMailer.welcome_email(user).deliver_now
  end
end
