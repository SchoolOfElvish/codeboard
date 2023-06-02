# frozen_string_literal: true

module Courses
  class Show < Core::Service
    def call(params)
      @params = params
      @id = (params[:id]).delete(':')
      course = Course.find(id)
      course ? Success(prepare_json(course)) : Failure(course.errors)
    end

    private

    attr_reader :params, :id

    def prepare_json(course)
      {
        id: course.id,
        name: course.name,
        user: {
          first_name: course.user.first_name,
          last_name: course.user.last_name
        }
      }
    end
  end
end
