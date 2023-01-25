# frozen_string_literal: true

module Jwt
  module Decoder
    module_function

    def decode!(access_token, verify: true)
      decoded = JWT.decode(access_token, Jwt::Secret.secret, verify, verify_iat: true)[0]
      raise Errors::Jwt::InvalidToken unless decoded.present?

      decoded.symbolize_keys
    end

    def decode(access_token, verify: true)
      decode!(access_token, verify: verify)
    rescue StandardError
      nil
    end
  end
end
