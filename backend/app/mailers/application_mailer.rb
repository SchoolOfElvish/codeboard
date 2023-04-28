# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'schoolofelvisher@gmail.com'
  layout 'mailer'
end
