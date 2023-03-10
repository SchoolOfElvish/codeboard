# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate!, only: %i[sign_up sign_in refresh]

      def sign_up
        case register_user
        in Success[token, refresh_token]
          render json: { token:, refresh_token: }, status: :created
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      def sign_in
        case log_in
        in Success[token, refresh_token]
          render json: { token:, refresh_token: }, status: :created
        in Failure[error]
          render json: { error: }, status: :forbidden
        end
      end

      def sign_out
        case log_out
        in Success
          render json: nil, status: :ok
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      def refresh
        case refresh_token
        in Success[token, refresh_token]
          render json: { token:, refresh_token: }, status: :created
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      private

      def log_out
        Users::SignOut.new.call(user: current_user, token: token_params[:token])
      end

      def log_in
        Users::SignIn.new.call(email: user_params[:email], password: user_params[:password])
      end

      def register_user
        Users::Register.new.call(user_params)
      end

      def refresh_token
        Sessions::Refresher.new.call(token_params:)
      end

      def token_params
        params.permit(:token, :refreshToken)
      end

      def user_params
        params.permit(:role, :firstName, :lastName, :email, :password, :passwordConfirmation)
      end
    end
  end
end
