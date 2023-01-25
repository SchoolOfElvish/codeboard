# frozen_string_literal: true

module Users
  class Register
    def call(email:, password:, password_confirmation:)
      @email = email
      @password = password
      @password_confirmation = password_confirmation

      user = User.create!(email: email, password: password, password_confirmation: password_confirmation)

      Jwt::Issuer.call(user)
    end

    private

    attr_reader :email, :password, :password_confirmation
  end
end
