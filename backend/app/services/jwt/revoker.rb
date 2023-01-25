# frozen_string_literal: true

module Jwt
  module Revoker
    module_function

    def revoke(decoded_token:, user:)
      jti = decoded_token.fetch(:jti)
      exp = decoded_token.fetch(:exp)

      Jwt::Whitelister.remove_whitelist!(jti:)
      Jwt::Blacklister.blacklist!(
        jti:,
        exp:,
        user:
      )
    rescue StandardError
      raise Errors::Jwt::InvalidToken
    end
  end
end
