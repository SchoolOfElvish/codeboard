# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
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
        in Success()
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
        Users::GetUserData.new.call(user: current_user)
      end

      def user_info_params
        params.permit(:first_name, :last_name, :birthdate)
      end
    end
  end
end
