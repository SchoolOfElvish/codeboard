# frozen_string_literal: true

module Jwt
  module Whitelister
    module_function

    def whitelist!(jti:, exp:, user:)
      user.whitelisted_tokens.create!(
        jti: jti,
        exp: Time.at(exp)
      )
    end

    def remove_whitelist!(jti:)
      whitelist = WhitelistedToken.find_by(
        jti: jti
      )
      whitelist.destroy if whitelist.present?
    end

    def whitelisted?(jti:)
      WhitelistedToken.exists?(jti: jti)
    end
  end
end
