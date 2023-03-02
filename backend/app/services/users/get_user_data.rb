# frozen_string_literal: true

module Users
  class GetUserData < Core::Service
    def call(user:)
      user_data = {
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        birthdate: user.birthdate
      }
      Success(user_data)
    end
  end
end
