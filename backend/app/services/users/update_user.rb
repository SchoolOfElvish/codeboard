# frozen_string_literal: true

module Users
  class UpdateUser < Core::Service
    def call(user:, user_params:, url_params: nil)
      @user = user
      @user_params = user_params
      @url_params = url_params

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
    
    def put_avatar_if_url_params_present
      return Success() unless url_params
      Users::PutAvatar.new.call(url_params, user)
    end

    def update_info
      result = put_avatar_if_url_params_present
      return Failure() if result == Failure()

      user.update(user_info) ? Success(user) : Failure(user.errors)
    end
  end
end