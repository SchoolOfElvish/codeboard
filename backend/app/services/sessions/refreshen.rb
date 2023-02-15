# frozen_string_literal: true

module Sessions
  class Refreshen < Core::Service
    def call
      Jwt::Refresher.refresh!(token_info)
    end

    private

    def token_info
      {
        decoder_token: params[:token],
        refresh_token: params[:refresh_token],
        user: current_user
      }
    end
  end
end
