# frozen_string_literal: true

module Users
  class Register < Core::Service
    def call(user_params)
      @user_params = user_params
      user = yield create_user
      token, refresh_token = yield issue_token(user)
      Success[token, refresh_token]
    end

    private

    def create_user
      user = User.new(user_info)
      user.save ? Success(user) : Failure(user.errors)
    end

    def user_info
      {
        role: user_params[:role],
        first_name: user_params[:firstName],
        last_name: user_params[:lastName],
        email: user_params[:email],
        password: user_params[:password],
        password_confirmation: user_params[:passwordConfirmation]
      }
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end

    attr_reader :user_params
  end
end
