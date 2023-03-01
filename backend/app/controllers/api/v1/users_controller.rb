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

      def getData
        case get_data
        in Success[email]
          render json: {email:}, status: :created
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

      def get_data
        Users::GetData.new.call(user: current_user)
      end
      
    end
  end
end
