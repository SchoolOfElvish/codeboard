# frozen_string_literal: true

module Users
  class SignOut < Core::Service
    def call(user)
      @user = user
      token = yield acceess_token
      decoded_token = yield decode_token(token)
      result = yield logout(decoded_token, user)
      Success(result)
    end

    private

    attr_reader :user

    def acceess_token
      Success(Jwt::Encoder.call(user)[0])
    rescue StandardError
      Failure(:token_is_blank)
    end

    def decode_token(token)
      Success(Jwt::Decoder.decode!(token))
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
