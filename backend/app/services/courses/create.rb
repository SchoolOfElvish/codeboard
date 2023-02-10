# frozen_string_literal: true

module Courses
  class Create < Core::Service
    def call(params:, user:)
      @params = params
      @user = user
      course.user_id = user.id
      course.save ? Success(course) : Failure(course.errors)
    end

    private

    attr_reader :params, :user

    def course
      @course ||= Course.new(params)
    end
  end
end
