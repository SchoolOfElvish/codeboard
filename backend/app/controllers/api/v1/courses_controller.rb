# frozen_string_literal: true

module Api
  module V1
    class CoursesController < CoreController
      include Dry::Monads::Result::Mixin

      def index
        @courses = search_courses(Course.includes(:user).limit(100))
        render json: prepare_json_for_list(@courses)
      end

      def create
        case course_creation
        in Success(course)
          render json: prepare_json(course), status: :created
        in Failure(error)
          render json: { errors: error.messages }, status: :unprocessable_entity
        end
      end

      private

      def search_courses(courses)
        if params[:search].present?
          courses.where('name LIKE ?', "%#{params[:search]}%")
        else
          courses
        end
      end

      def prepare_json_for_list(courses)
        courses.map { |course| prepare_json(course) }
      end

      def prepare_json(course)
        {
          id: course.id,
          name: course.name,
          user: {
            first_name: course.user.first_name
          }
        }
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
