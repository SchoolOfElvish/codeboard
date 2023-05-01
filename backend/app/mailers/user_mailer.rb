# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user_id)
    @user = User.find_by(id: user_id)
    mail(to: @user.email, subject: "Welcome!")
  end
end
