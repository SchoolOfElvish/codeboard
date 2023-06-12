# frozen_string_literal: true

module Jwt
  module Secret
    module_function

    def secret
      ENV.fetch('JWT_SECRET') { Rails.application.secrets.secret_key_base }
    end
  end
end
