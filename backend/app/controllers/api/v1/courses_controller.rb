# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Dry::Monads::Result::Mixin

      def index
        @courses = search_courses(Course.all.limit(100))
        render json: @courses
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

      def search_courses(courses)
        courses = courses.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
        courses.map do |course|
          {
            name: course.name,
            user: {
              first_name: course.user.first_name
            }
          }
        end
      end

      def course_creation
        Courses::Create.new.call(user: current_user, params: course_params)
      end

      def course_params
        params.permit(:name)
      end
    end
  end
end
