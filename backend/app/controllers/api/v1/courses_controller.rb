# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      def create
        @course = current_user.course.new(course_params)

        if @course.save
          json_response(@course, :created)
        else
          json_response(@course, :unprocessable_entity)
        end
      end

      private

      def course_params
        params.require(:course).permit(:name, :user_id).merge(user: current_user)
      end
    end
  end
end
