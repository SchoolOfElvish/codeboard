# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate, only: %i[sign_up sign_in]

      def sign_up
        result = Users::Register.new.call(
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        )

        case result
        in Success[token, refresh_token]
          render json: { token: token, refresh_token: refresh_token }, status: :created
        in Failure[error]
          render json: { error: error }, status: :unprocessable_entity
        end
      end

      def sign_in
      end

      def sign_out
      end
    end
  end
end
