# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Dry::Monads::Result::Mixin
      before_action :set_user

      def show
        if user
          render json: formatted_user_data, status: :ok
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      private

      attr_reader :user

      def user_params
        params.permit(:id)
      end

      def set_user
        @user = User.find_by(id: user_params[:id])
      end

      def formatted_user_data
        {
          first_name: @user.first_name,
          last_name: @user.last_name,
          role: @user.role,
          created_at: @user.created_at.to_date
        }
      end
    end
  end
end
