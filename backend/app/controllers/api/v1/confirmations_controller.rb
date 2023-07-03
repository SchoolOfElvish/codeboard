# frozen_string_literal: true

module Api
  module V1
    class ConfirmationsController < CoreController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate!, only: %i[confirm_email]
      def confirm_email
        confirmation_token = params[:confirmation_token]

        user = User.find_by(confirmation_token:)
        user.confirm
        token, refresh_token = issue_token(user)
        render json: { token:, refresh_token: }, status: :created
      end

      private

      attr_reader :user

      def issue_token(user)
        token, refresh_token = Jwt::Issuer.call(user)
        Success[token, refresh_token.token]
      end
    end
  end
end
