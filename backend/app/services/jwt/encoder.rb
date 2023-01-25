# frozen_string_literal: true

module Jwt
  module Encoder
    module_function

    def call(user)
      jti = SecureRandom.hex
      exp = Jwt::Encoder.token_expiry
      access_token = JWT.encode(
        {
          user_id: user.id,
          jti: jti,
          iat: Jwt::Encoder.token_issued_at.to_i,
          exp: exp
        },
        Jwt::Secret.secret
      )

      [access_token, jti, exp]
    end

    def token_expiry
      (Jwt::Encoder.token_issued_at + Jwt::Expiry.expiry).to_i
    end

    def token_issued_at
      Time.now
    end
  end
end
