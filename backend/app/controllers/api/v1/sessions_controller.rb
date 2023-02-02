# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate!, only: %i[sign_up sign_in]

      def sign_up
        case register_user
        in Success[token, refresh_token]
          render json: { token:, refresh_token: }, status: :created
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      def sign_in; end

      def sign_out; end

      private

      def register_user
        Users::Register.new.call(
          role: params[:role],
          first_name: params[:firstName],
          last_name: params[:lastName],
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:passwordConfirmation]
        )
      end
    end
  end
end
