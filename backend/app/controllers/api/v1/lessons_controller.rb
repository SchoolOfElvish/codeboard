# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Dry::Monads::Result::Mixin

      def index
        case fetch_lessons
        in Success(*lessons)
          render json: lessons, status: :ok
        end
      end

      def create
        case create_lesson
        in Success(lesson)
          render json: lesson, status: :created
        in Failure(error)
          render json: { errors: error.messages }, status: :unprocessable_entity
        end
      end

      private

      def fetch_lessons
        Lessons::Fetch.new.call(course_id: params[:course_id])
      end

      def create_lesson
        Lessons::Create.new.call(params: lesson_params, current_user:)
      end

      def lesson_params
        params.permit(:course_id, :title, :description)
      end
    end
  end
end
