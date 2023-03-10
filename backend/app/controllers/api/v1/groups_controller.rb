# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include Dry::Monads::Result::Mixin

      def create
        case group_creation
        in Success(group)
          render json: group, status: :created
        in Failure(error)
          render json: { errors: error.messages }, status: :unprocessable_entity
        end
      end

      private

      def group_creation
        Groups::Create.new.call(user: current_user, params: group_params)
      end

      def group_params
        params.permit(:title,:email)
      end
    end
  end
end
