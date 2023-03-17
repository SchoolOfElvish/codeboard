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
    I18n.locale = extract_locale_from_accept_language_header
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
