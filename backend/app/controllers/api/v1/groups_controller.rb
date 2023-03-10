# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include Dry::Monads::Result::Mixin

      def create
        case group_creation
        in Success(group)
          render json: course, status: :created
        in Failure(error)
          render json: { errors: error.messages }, status: :unprocessable_entity
        end
      end

      private

      def group_creation
        Courses::Create.new.call(user: current_user, params: course_params)
      end

      def group_params
        params.permit(:title)
      end
    end
  end
end
