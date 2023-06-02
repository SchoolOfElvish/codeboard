# frozen_string_literal: true

module Courses
  class Search < Core::Service
    def call(params, current_user)
      @params = params
      @user = current_user
      @courses_sample = Course.includes(:user).limit(100)
      @courses = if @user
                   search_courses_for_authorized_user(courses_sample)
                 else
                   search_courses_for_unauthorized_user(courses_sample)
                 end
      courses_found = prepare_json_for_list(courses)
      Success(courses_found)
    end

    private

    attr_reader :params, :courses, :courses_sample

    def search_courses_for_authorized_user(courses)
      if params[:search].present?
        courses.where(user_id: @user.id).where('name LIKE ?', "%#{params[:search]}%")
      else
        courses.where(user_id: @user.id)
      end
    end

    def search_courses_for_unauthorized_user(courses)
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
          first_name: course.user.first_name,
          last_name: course.user.last_name
        }
      }
    end
  end
end
