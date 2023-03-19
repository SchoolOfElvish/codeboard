# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Dry::Monads::Result::Mixin

      def show


      end

      
      def create
        case course_creation
        in Success(course)
          render json: course, status: :created
        in Failure(error)
          render json: { errors: error.messages }, status: :unprocessable_entity
        end
      end

      private

      def course_creation
        Courses::Create.new.call(user: current_user, params: course_params)
      end

      def course_params
        params.permit(:name)
      end
    end
  end
end
