# frozen_string_literal: true

module Users
  class SignIn < Core::Service
    def call(user_params)
      @user_params = user_params
      @email = user_params[:email]
      @password = user_params[:password]
      @user = find_user(@email)
      validate_password(@password)
      token, refresh_token = yield issue_token(user)
      Success[token, refresh_token]
    end

    private
    
    def find_user(email)
      user = User.find_by(email)
      user ? Success(user) : Failure(user.errors) 
    end

    def validate_password(password)
      @user.valid_password?(password)
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end

  end
end