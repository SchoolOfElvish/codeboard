# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Dry::Monads::Result::Mixin

      skip_before_action :authenticate!, only: %i[all]

      def index
        case course_search
        in Success(*courses_found)
          render json: courses_found, status: :ok
        end
      end

      def all
        case course_search
        in Success(*courses_found)
          render json: courses_found, status: :ok
        end
      end

      def show
        case course_show
        in Success(course)
          render json: course, status: :created
        in Failure(error)
          render json: { errors: error }, status: :not_found
        end
      end

      def create
        case course_creation
        in Success(course)
          render json: course, status: :created
        in Failure(error)
          render json: { errors: error.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def course_creation
        Courses::Create.new.call(user: current_user, params: course_params)
      end

      def course_search
        Courses::Search.new.call(params:, current_user:)
      end

      def course_show
        Courses::Show.new.call(params:)
      end

      def course_params
        params.permit(:name)
      end
    end
  end
end
