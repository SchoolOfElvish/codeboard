# frozen_string_literal: true

module Users
  class SignOut < Core::Service
    def call(user:, token:)
      @user = user
      @token = token

    end

    private

    def decode_token
      Success(Jwt::Decoder.decode!(token, verify: false))
    rescue StandardError
      Failure(:token_cannot_be_decoded)
    end

    def logout()

    end
  end
end
