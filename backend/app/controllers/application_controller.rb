# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authenticate!, :set_locale

  wrap_parameters format: []

  private

  def authenticate!
    current_user, decoded_token = Jwt::Authenticator.call(
      headers: request.headers,
      access_token: params[:access_token] # authenticate from header OR params
    )

    @current_user = current_user
    @decoded_token = decoded_token
  rescue JWT::ExpiredSignature
    head :unauthorized
  end

  def set_locale
    I18n.locale = valid_locale || I18n.default_locale
  end

  def valid_locale
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first
    locale if I18n.available_locales.map(&:to_s).include?(locale)
  end
end
