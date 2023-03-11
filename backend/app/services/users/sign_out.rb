# frozen_string_literal: true

module Users
  class SignOut < Core::Service
    def call(user:, token:)
      @user = user
      @token = token

      decoded_token = yield decode_token
      result = yield logout(decoded_token, user)
      Success(result)
    end

    private

    attr_reader :user, :token, :decoded_token

    def decode_token
      Success(Jwt::Decoder.decode!(token, verify: false))
    rescue StandardError
      Failure(:token_cannot_be_decoded)
    end

    def logout(decoded_token, user)
      Success(Jwt::Revoker.revoke(decoded_token:, user:))
    rescue StandardError
      Failure(:unprocessable_entity)
    end
  end
end
