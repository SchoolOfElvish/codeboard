# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Dry::Monads::Result::Mixin

      def update
        case add_birthdate
        in Success()
          head :no_content
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
          end
      end

      def show
        # binding.pry 
        case get_user_data
        in Success[user_data]
          render json: user_data, status: :ok
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      private

      def add_birthdate
        Users::Update.new.call(
          user: current_user,
          birthdate: params[:birthdate]
        )
      end

      def get_user_data
        Users::GetUserData.new.call(user: current_user)
      end
      
    end
  end
end
