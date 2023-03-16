# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      include Dry::Monads::Result::Mixin

      def show
        case receive_user_data
        in Success[user_data]
          render json: user_data, status: :ok
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      def update
        case update_user_info
        in Success(user)
          head :no_content
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      private

      def update_user_info
        Users::UpdateUserInfo.new.call(
          user: current_user,
          user_params: user_info_params
        )
      end

      def receive_user_data
        user_data = {
          first_name: current_user.first_name,
          last_name: current_user.last_name,
          email: current_user.email,
          birthdate: current_user.birthdate
        }
        Success(user_data)
      end

      def user_info_params
        params.permit(:first_name, :last_name, :birthdate)
      end
    end
  end
end
