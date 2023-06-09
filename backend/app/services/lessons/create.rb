# frozen_string_literal: true

module Lessons
  class Create < Core::Service
    def call(params:, current_user:)
      @params = params # expected parameters in params: course_id, title, description, current_user
      if Course.find(params['course_id']).user_id == current_user.id
        lesson.save ? Success(lesson) : Failure(lesson.errors)
      else
        Failure(ActiveModel::Errors.new(self)) # TODO: Add custom message
      end
    end

    private

    attr_reader :params, :course

    def lesson
      @lesson ||= Lesson.new(params)
    end
  end
end
