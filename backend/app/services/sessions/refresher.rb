# frozen_string_literal: true

module Sessions
  class Refresher < Core::Service
    def call(token_params:, user:)
      @token_params = token_params
      @user = user

      decoded_token = yield decode_token
      token, refresh_token = yield refresh_token(decoded_token)

      Success[token, refresh_token.token]
    end

    private

    attr_reader :token_params, :user

    def refresh_token(decoded_token)
      result = Jwt::Refresher.refresh!(
        decoded_token:,
        refresh_token: token_params[:refresh_token],
        user:
      )
      Success(result)
    rescue Errors::Jwt::MissingToken
      Failure(:token_is_missing)
    rescue StandardError
      Failure(:token_cannot_be_refreshed)
    end

    def decode_token
      Success(Jwt::Decoder.decode!(token_params[:token]))
    rescue StandardError
      Failure(:token_cannot_be_decoded)
    end
  end
end
