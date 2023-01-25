# frozen_string_literal: true

module Jwt
  module Encoder
    module_function

    # rubocop:disable Metrics/MethodLength
    def call(user)
      jti = SecureRandom.hex
      exp = Jwt::Encoder.token_expiry
      access_token = JWT.encode(
        {
          user_id: user.id,
          jti:,
          iat: Jwt::Encoder.token_issued_at.to_i,
          exp:
        },
        Jwt::Secret.secret
      )

      [access_token, jti, exp]
    end
    # rubocop:enable Metrics/MethodLength

    def token_expiry
      (Jwt::Encoder.token_issued_at + Jwt::Expiry.expiry).to_i
    end

    def token_issued_at
      Time.zone.now
    end
  end
end
