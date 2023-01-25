# frozen_string_literal: true

module Jwt
  module Refresher
    module_function

    # rubocop:disable Metrics/MethodLength
    def refresh!(refresh_token:, decoded_token:, user:)
      raise Errors::Jwt::MissingToken, token: 'refresh' unless refresh_token.present? || decoded_token.nil?

      existing_refresh_token = user.refresh_tokens.find_by(
        token: refresh_token
      )
      raise Errors::Jwt::InvalidToken, token: 'refresh' if existing_refresh_token.blank?

      jti = decoded_token.fetch(:jti)

      new_access_token, new_refresh_token = Jwt::Issuer.call(user)
      existing_refresh_token.destroy!

      Jwt::Blacklister.blacklist!(jti:, exp: decoded_token.fetch(:exp), user:)
      Jwt::Whitelister.remove_whitelist!(jti:)

      [new_access_token, new_refresh_token]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
