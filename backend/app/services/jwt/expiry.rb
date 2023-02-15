# frozen_string_literal: true

module Jwt
  module Expiry
    module_function

    def expiry
      10.seconds
    end
  end
end
