# frozen_string_literal: true

module Users
  class SignOut < Core::Service
    def call(headers)
      @headers = headers

      token = yield acceess_token
      decoded_token = yield decode_token(token)
      user = yield current_user(decoded_token)
      result = yield logout(decoded_token, user)
      Success(result)
    end

    private

    attr_reader :headers, :token, :decoded_token, :user

    def acceess_token
      Success(Jwt::Authenticator.authenticate_header(headers))
    rescue StandardError
      Failure(:token_is_blank)
    end

    def current_user(decoded_token)
      Success(Jwt::Authenticator.authenticate_user_from_token(decoded_token))
    rescue StandardError
      Failure(:user_unauthorized)
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
