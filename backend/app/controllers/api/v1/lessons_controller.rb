# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Dry::Monads::Result::Mixin
      def create
        case create_lesson
        in Success(lesson)
          render json: lesson, status: :created
        in Failure(error)
          render json: { errors: error.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def create_lesson
        Lessons::Create.new.call(params: lesson_params)
      end

      def lesson_params
        params.permit(:course_id, :title, :description)
      end
    end
  end
end
