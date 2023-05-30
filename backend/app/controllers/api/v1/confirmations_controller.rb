# frozen_string_literal: true

module Api
  module V1
    class ConfirmationsController < CoreController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate!, only: %i[confirm_email]
      
      def confirm_email
        confirmation_token = params[:confirmations_token]
        user = User.comfirm_by_token(confirmation_token)
        token, refresh_token = Jwt::Issuer.call(user)
        render json: { token:, refresh_token: }, status: ok
      end
    end
  end
end
