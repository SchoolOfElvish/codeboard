# frozen_string_literal: true

module Courses
  class Search < Core::Service
    def call(params)
      @params = params
      @courses = search_courses(Course.includes(:user).limit(100))
      courses_found = prepare_json_for_list(courses)
      Success(courses_found)
    end

    private

    attr_reader :params, :courses

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
  end
end
