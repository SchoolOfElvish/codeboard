# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Dry::Monads::Result::Mixin

      def show
        @user = User.find(user_params[:id])
        case receive_user_data(@user)
          in Success[user_data]
            render json: user_data, status: :ok
          in Failure[error]
            render json: { error: }, status: :unprocessable_entity
         end
      end

      private

      def user_params
        params.permit(:id)
      end

      def receive_user_data(user)
        user_data = 
        {
          first_name: user.first_name,
          last_name: user.last_name,
          role: user.role,
          created_at: user.created_at.to_date
        }
        Success(user_data)
      end

      
    end
  end
end
