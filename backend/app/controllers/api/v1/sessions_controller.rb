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
            render json: { error: }, status: :unprocessable_entity
        end
      end

      def sign_out; end

      def refresh
        case refresh_token
        in Success[token, refresh_token]
          render json: { token:, refresh_token: }, status: :created
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      def hello
        head :ok
      end

      private

      def log_in
        Users::SignIn.new.call(login_params)
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

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
