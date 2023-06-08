# frozen_string_literal: true

module Courses
  class Show < Core::Service
    def call(params:)
      @params = params
      @id = (params[:id]).delete(':')
      begin
        course = Course.find(id)
      rescue ActiveRecord::RecordNotFound
        error = "Couldn't find Course with 'id'=#{id}"
      end
      course ? Success(prepare_json(course)) : Failure(error)
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
