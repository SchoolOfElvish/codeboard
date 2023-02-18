# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authenticate!

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
end
