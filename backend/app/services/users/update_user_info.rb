# frozen_string_literal: true

module Users
  class UpdateUserInfo < Core::Service
    def call(user:, user_params:)
      @user = user
      @user_params = user_params
      update_info
    end

    private

    attr_reader :user, :user_params, :first_name, :last_name, :birthdate, :about_info

    def user_info
      {
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        birthdate: user_params[:birthdate],
        about_info: user_params[:about_info]
      }
    end

    def update_info
      user.update(user_info) ? Success(user) : Failure(user.errors)
    end
  end
end
