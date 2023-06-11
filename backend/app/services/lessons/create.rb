# frozen_string_literal: true

module Lessons
  class Create < Core::Service
    def call(params:)
      @params = params # expected parameters in params: course_id, title, description, current_user
      lesson.save ? Success(lesson) : Failure(lesson.errors)
    end

    private

    attr_reader :params, :course

    def lesson
      @lesson ||= Lesson.new(params)
    end
  end
end
