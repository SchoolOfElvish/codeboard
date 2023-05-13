# frozen_string_literal: true

module Users
  class UpdateUser < Core::Service
    def call(user:, user_params:)
      @user = user
      @user_params = user_params
      @signed_blob_id = @user_params[:signed_blob_id]

      update_info
    end

    private

    attr_reader :user, :user_params, :first_name, :last_name, :birthdate, :about_info, :signed_blob_id

    def user_info
      {
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        birthdate: user_params[:birthdate],
        about_info: user_params[:about_info]
      }
    end

    def put_avatar
      Users::PutAvatar.new.call(signed_blob_id, user)
    end

    def update_info
      result = put_avatar if signed_blob_id.present?

      return Failure() if result == Failure()

      user.update(user_info) ? Success(user) : Failure(user.errors)
    end
  end
end
