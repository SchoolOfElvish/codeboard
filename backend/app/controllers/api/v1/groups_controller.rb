# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include Dry::Monads::Result::Mixin

      def create
        case group_creation
        in Success(group)
          render json: group.to_json, status: :created
        in Failure(error)
          render json: error.to_json, status: :unprocessable_entity
        end
      end

      private

      def group_creation
        Groups::Create.new.call(params: group_params, user: current_user)
      end

      def group_params
        params.permit(:name)
      end
    end
  end
end
