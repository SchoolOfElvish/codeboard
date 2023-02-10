# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def create
        @course = Courses::Create.new.call(params: course_params, user: current_user)
        if @course.persisted?
          render json: course_params.to_json, status: :created
        else
          render json: course_params.to_json, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.permit(:name)
      end
    end
  end
end
