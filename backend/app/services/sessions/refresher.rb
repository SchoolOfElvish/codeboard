# frozen_string_literal: true

module Sessions
  class Refresher < Core::Service
    def call(token_params:)
      @token_params = token_params

      decoded_token = yield decode_token
      user = yield get_user_by(decoded_token[:id])
      token, refresh_token = yield refresh_token(decoded_token, user)

      Success[token, refresh_token.token]
    end

    private

    attr_reader :token_params

    def refresh_token(decoded_token, user)
      result = Jwt::Refresher.refresh!(
        decoded_token:,
        refresh_token: token_params[:refreshToken],
        user:
      )
      Success(result)
    rescue Errors::Jwt::MissingToken
      Failure(:token_is_missing)
    rescue StandardError
      Failure(:token_cannot_be_refreshed)
    end

    def decode_token
      Success(Jwt::Decoder.decode!(token_params[:token], verify: false))
    rescue StandardError
      Failure(:token_cannot_be_decoded)
    end

    def get_user_by(user_id)
      Success(User.find(user_id))
    rescue StandardError
      Failure(:user_not_found)
    end
  end
end
