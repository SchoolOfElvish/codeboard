# frozen_string_literal: true

module Users
  class Register < Core::Service
    def call(email:, password:, password_confirmation:)
      @email = email
      @password = password
      @password_confirmation = password_confirmation

      user = yield create_user
      token, refresh_token = yield issue_token(user)
      Success[token, refresh_token]
    end

    private

    def create_user
      user = User.create(email:, password:, password_confirmation:)

      user.valid? ? Success(user) : Failure(user.errors)
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end

    attr_reader :email, :password, :password_confirmation
  end
end
