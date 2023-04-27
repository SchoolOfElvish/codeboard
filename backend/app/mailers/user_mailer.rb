# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user_id)
    @user = User.find_by_id(user_id)
    mail(to: @user.email, subject: 'Welcome to Codeboard')
  end
end
