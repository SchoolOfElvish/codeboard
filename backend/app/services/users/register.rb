# frozen_string_literal: true

module Users
  class Register < Core::Service
    def call(user_params)
      @user_params = user_params
      # @email = email
      # @password = password
      # @password_confirmation = password_confirmation
      # @first_name = first_name
      # @last_name = last_name
      # @role = role.to_i

      user = yield create_user
      token, refresh_token = yield issue_token(user)
      Success[token, refresh_token]
    end

    private

    def create_user
      user = User.new(user_params)
      user.save ? Success(user) : Failure(user.errors)
    end

    def issue_token(user)
      token, refresh_token = Jwt::Issuer.call(user)
      Success[token, refresh_token.token]
    end

    attr_reader :user_params
  end
end
