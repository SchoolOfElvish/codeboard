class CoursePolicy < ApplicationPolicy
  def create
    if user.role == 'teacher'
      Success()
    else
      Failure(:not_teacher)
    end
  end
end