# frozen_string_literal: true

module Users
  class SignIn < Core::Service
    def call(email:, password:)
      @email = email
      @password = password
      @user = yield find_user(@email)
      validation = validate_password(@password)
      if validation.instance_of?(Dry::Monads::Result::Success)
        token, refresh_token = yield issue_token(@user)
        Success[token, refresh_token]
      else
        validation
      end
    end

    private

    def find_user(email)
      user = User.find_by(email: email.to_s)
      user ? Success(user) : Failure('User not found')
    end

    def validate_password(password)
      if @user.valid_password?(password)
        Success()
      else
        Failure('Wrong password')
      end
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end
  end
end
