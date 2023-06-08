# frozen_string_literal: true

module Lessons
  class Fetch < Core::Service
    def call(course_id:)
      @course_id = course_id
      @fetched_lessons = Lesson.where(course_id:)
      lessons = prepare_json_for_list(fetched_lessons)
      Success(lessons)
    end

    private

    attr_reader :kourse_id, :fetched_lessons

    def prepare_json_for_list(fetched_lessons)
      fetched_lessons.map { |lesson| prepare_json(lesson) }
    end

    def prepare_json(lesson)
      {
        id: lesson.id,
        title: lesson.title,
        description: lesson.description
      }
    end
  end
end
