# frozen_string_literal: true

module Users
  class SignIn < Core::Service
    def call(user_params)
      @user_params = user_params
      @password = user_params[:password]
    end

    private

    def validate_password
      user.valid_password?(password)
    end


  end
end