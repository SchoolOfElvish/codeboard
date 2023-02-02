# frozen_string_literal: true

module Users
  class Register < Core::Service
    def call(role:, first_name:, last_name:, email:, password:, password_confirmation:)
      @email = email
      @password = password
      @password_confirmation = password_confirmation
      @first_name = first_name
      @last_name = last_name
      @role = role.to_i

      user = yield create_user
      token, refresh_token = yield issue_token(user)
      Success[token, refresh_token]
    end

    private

    def create_user
      user = User.new(role:, last_name:, first_name:, email:, password:, password_confirmation:)

      user.save ? Success(user) : Failure(user.errors)
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end

    attr_reader :role, :last_name, :first_name, :email, :password, :password_confirmation
  end
end
